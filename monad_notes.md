Monads
======

    Functor -> Apply -> Applicative 
                 |         |
                 v         v
               Bind  ->  Monad

Functor
-------

##### effmap
```haskell
class Functor f where
  (<$>) :: (a -> b) -> f a -> f b
```
Instances of `<$>` for each type class

##### annonymous map
```haskel
(<$) :: Functor f =>
  a -> f b -> f a
a <$ f =
  const a <$> f
```

##### void
```haskell
void :: Functor f =>
  f a -> f ()
void =
  (<$) ()
```

Apply
-----
```haskell
class Functor f => Apply f where
  (<*>) :: f (a -> b) -> f a -> f b
```
Instances of `<*>` for each type class

##### lifts
```haskell
lift2 :: Apply f =>
  (a -> b -> c) -> f a -> f b -> f c
lift2 f a b =
   (f <$> a) <*> b

lift3 :: Apply f =>
  (a -> b -> c -> d) -> f a -> f b -> f c -> f d
lift3 f a b c =
  f <$> a <*> b <*> c
 
lift4 :: Apply f =>
  (a -> b -> c -> d -> e) -> f a -> f b -> f c -> f d -> f e
lift4 f a b c d =
  f <$> a <*> b <*> c <*> d
  
etc
```

##### left apply
```haskell
(*>) :: Apply f =>
  f a -> f b -> f b
(*>) =
  lift2 (const id)
```

##### right apply
```
(<*) :: Apply f =>
  f b -> f a -> f b
(<*) =
  lift2 const 
```

Applicative
-----------

```haskell
class Apply f => Applicative f where
  pure :: a -> f a
```
Instances of pure for each typeclass

##### effmap
Using:
```haskell
Apply :: <*>
Applicative :: pure
```
effmap:
```haskell
(<$>) :: Applicative f =>
  (a -> b) -> f a -> f b
f <$> a =
  pure f <*> a
```

##### sequence
```haskell
sequence :: Applicative f =>
  List (f a) -> f (List a)
sequence = 
    foldRight (lift2 (:.)) (pure Nil)
```

##### replicateA
```haskell
replicateA :: Applicative f =>
  Int -> f a -> f (List a)
replicateA n =
  sequence . replicate n
```

##### filtering
```haskell
filtering :: Applicative f =>
  (a -> f Bool) -> List a -> f (List a)
filtering p =
  foldRight(\a -> lift2 (\b ->  if b then (a:.) else id) (p a)) (pure Nil)
```

Bind
----
```haskell
class Apply f => Bind f where
  (=<<) :: (a -> f b) -> f a -> f b
```

Monad
-----
```haskell
class (Applicative f, Bind f) => Monad f where
```
Empty instances for each type class
