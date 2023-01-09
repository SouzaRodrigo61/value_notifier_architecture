enum Env {
  live,
  mock,
}

class Envronment {
  final Env _env;

  Envronment(this._env);

  Env get envronment => _env;
}
