defmodule Numexy.Mixfile do
  use Mix.Project

  def project do
    [
      app: :numexy,
      version: "0.1.9",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      description: "It is a library for matrix and vector calculation.",
      package: [
        maintainers: ["Yuji Kawakami", "Susumu Yamazaki"],
        licenses: ["Apache 2.0"],
        links: %{"GitHub" => "https://github.com/yujikawa/numexy"}
      ],
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:excoveralls, "~> 0.7", only: :test}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
