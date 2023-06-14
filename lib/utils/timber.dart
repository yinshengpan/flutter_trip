class Timber {
  static final Timber _instance = Timber._internal();

  final _ForestTree _forestTree = _ForestTree();

  Timber._internal();

  static Tree tag(String tag) {
    _instance._forestTree.tag(tag);
    return _instance._forestTree;
  }

  static void plant([List<Tree>? trees]) {
    _instance._forestTree.plant(trees);
  }

  static void d(dynamic message) {
    _instance._forestTree.d(message);
  }

  static void e([dynamic message = "", StackTrace? stackTrace]) {
    _instance._forestTree.e(message, stackTrace);
  }

  static void i(dynamic message) {
    _instance._forestTree.i(message);
  }

  static void v(dynamic message) {
    _instance._forestTree.v(message);
  }

  static void w([dynamic message = "", StackTrace? stackTrace]) {
    _instance._forestTree.w(message, stackTrace);
  }
}

class _ForestTree extends Tree {
  final List<Tree> _trees = [];

  void plant([List<Tree>? trees]) {
    trees?.forEach((tree) {
      if (!_trees.contains(tree)) {
        _trees.add(tree);
      }
    });
  }

  void tag(String tag) {
    _notifyTree((tree) {
      tree._tag = tag;
    });
  }

  @override
  void log(Log priority, String? message) {
    _notifyTree((tree) {
      tree.log(priority, message);
    });
  }

  @override
  void d(message) {
    _notifyTree((tree) {
      tree.d(message);
    });
  }

  @override
  void e([message = "", StackTrace? stackTrace]) {
    _notifyTree((tree) {
      tree.e(message, stackTrace);
    });
  }

  @override
  void i(message) {
    _notifyTree((tree) {
      tree.i(message);
    });
  }

  @override
  void v(message) {
    _notifyTree((tree) {
      tree.v(message);
    });
  }

  @override
  void w([message = "", StackTrace? stackTrace]) {
    _notifyTree((tree) {
      tree.w(message, stackTrace);
    });
  }

  void _notifyTree(final void Function(Tree) accept) {
    for (var tree in _trees) {
      accept(tree);
    }
  }
}

class DebugTree extends Tree {
  @override
  void log(Log priority, String? message) {
    print(message);
  }
}

abstract class Tree {
  String? _tag;

  void v(dynamic message) {
    _prepareLog(Log.VERBOSE, message);
  }

  void d(dynamic message) {
    _prepareLog(Log.DEBUG, message);
  }

  void i(dynamic message) {
    _prepareLog(Log.INFO, message);
  }

  void w([dynamic message = "", StackTrace? stackTrace]) {
    _prepareLog(Log.WARN, message, stackTrace);
  }

  void e([dynamic message = "", StackTrace? stackTrace]) {
    _prepareLog(Log.ERROR, message, stackTrace);
  }

  void _prepareLog(Log priority, dynamic message, [StackTrace? stackTrace]) {
    String date = DateTime.now().toString();
    String level = "[${priority.value}]";
    String tag = _tag == null ? "" : "[$_tag]";
    _tag = null;
    String msg = message?.toString() ?? "";
    String error = stackTrace == null ? "" : "\n${stackTrace.toString()}";
    String formatMessage = "$date$level$tag$msg$error";
    log(priority, formatMessage);
  }

  void log(Log priority, String? message);
}

class Log {
  static const Log VERBOSE = Log._(2, "VERBOSE");
  static const Log DEBUG = Log._(3, "DEBUG");
  static const Log INFO = Log._(4, "INFO");
  static const Log WARN = Log._(5, "WARN");
  static const Log ERROR = Log._(6, "ERROR");
  final int level;
  final String value;

  const Log._(this.level, this.value);
}
