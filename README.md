[![Build Status](https://travis-ci.org/larskuhtz/loglevel.svg?branch=master)](https://travis-ci.org/larskuhtz/loglevel)

# Log Level Datatype

This package provides a Haskell log-level datatype. It allows to specify APIs
with logging-callbacks without depending on a particular logging framework.

There is a large number of different Haskell logging frameworks that support
different use cases and backends. As a consequence these framework make
different trade-offs with respect to their architecture and implementation.
Often they have complex internals and many external dependencies.

While logging frameworks differ a lot in their internals and backends, they tend
to have similar frontends. In particular, many software components depend for
logging only on a callback function that typically has a type similar to

```haskell
loggingCallback ∷ LogLevel → Text → IO ()
```

The only framework-specific dependency is the `LogLevel` type. This type is in
most cases similar, often isomorphic, and sometimes even identical across
different frameworks.

It is unfortunate that a software component has to depend on a particular
logging framework (and all of the frameworks dependencies) just for using the
`LogLevel` type that is almost identical throughout most logging frameworks.

This package allows software components to include logging callbacks in their
APIs without depending on a particular logging framework.

---

Even more complex logging callbacks often have a type along the lines of

```haskell
genericLoggingCallback ∷ c a ⇒ LogLevel → a → IO ()
```

where `c` is a constraint made up from common type classes like `ToJSON`,
`Serializable`, `NFData`, or `Generic`.

