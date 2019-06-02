{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Data.Tuple.Minicute where

class TupleZipper1 t t' | t -> t' where
  {-# MINIMAL tupleUnzip1, tupleZip1 #-}
  tupleUnzip1 :: t -> t'
  tupleZip1 :: t' -> t

instance TupleZipper1 ((a, b), c) (a, b, c) where
  tupleUnzip1 ((a, b), c) = (a, b, c)
  tupleZip1 (a, b, c) = ((a, b), c)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

instance TupleZipper1 ((a, b), c, d) (a, b, c, d) where
  tupleUnzip1 ((a, b), c, d) = (a, b, c, d)
  tupleZip1 (a, b, c, d) = ((a, b), c, d)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

instance TupleZipper1 ((a, b), c, d, e) (a, b, c, d, e) where
  tupleUnzip1 ((a, b), c, d, e) = (a, b, c, d, e)
  tupleZip1 (a, b, c, d, e) = ((a, b), c, d, e)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

instance TupleZipper1 ((a, b), c, d, e, f) (a, b, c, d, e, f) where
  tupleUnzip1 ((a, b), c, d, e, f) = (a, b, c, d, e, f)
  tupleZip1 (a, b, c, d, e, f) = ((a, b), c, d, e, f)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

instance TupleZipper1 ((a, b), c, d, e, f, g) (a, b, c, d, e, f, g) where
  tupleUnzip1 ((a, b), c, d, e, f, g) = (a, b, c, d, e, f, g)
  tupleZip1 (a, b, c, d, e, f, g) = ((a, b), c, d, e, f, g)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

instance TupleZipper1 ((a, b), c, d, e, f, g, h) (a, b, c, d, e, f, g, h) where
  tupleUnzip1 ((a, b), c, d, e, f, g, h) = (a, b, c, d, e, f, g, h)
  tupleZip1 (a, b, c, d, e, f, g, h) = ((a, b), c, d, e, f, g, h)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

instance TupleZipper1 ((a, b), c, d, e, f, g, h, i) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip1 ((a, b), c, d, e, f, g, h, i) = (a, b, c, d, e, f, g, h, i)
  tupleZip1 (a, b, c, d, e, f, g, h, i) = ((a, b), c, d, e, f, g, h, i)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

instance TupleZipper1 ((a, b), c, d, e, f, g, h, i, j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip1 ((a, b), c, d, e, f, g, h, i, j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip1 (a, b, c, d, e, f, g, h, i, j) = ((a, b), c, d, e, f, g, h, i, j)
  {-# INLINEABLE tupleUnzip1 #-}
  {-# INLINEABLE tupleZip1 #-}

class TupleZipper2 t t' | t -> t' where
  {-# MINIMAL tupleUnzip2, tupleZip2 #-}
  tupleUnzip2 :: t -> t'
  tupleZip2 :: t' -> t

instance TupleZipper2 (a, (b, c)) (a, b, c) where
  tupleUnzip2 (a, (b, c)) = (a, b, c)
  tupleZip2 (a, b, c) = (a, (b, c))
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

instance TupleZipper2 (a, (b, c), d) (a, b, c, d) where
  tupleUnzip2 (a, (b, c), d) = (a, b, c, d)
  tupleZip2 (a, b, c, d) = (a, (b, c), d)
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

instance TupleZipper2 (a, (b, c), d, e) (a, b, c, d, e) where
  tupleUnzip2 (a, (b, c), d, e) = (a, b, c, d, e)
  tupleZip2 (a, b, c, d, e) = (a, (b, c), d, e)
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

instance TupleZipper2 (a, (b, c), d, e, f) (a, b, c, d, e, f) where
  tupleUnzip2 (a, (b, c), d, e, f) = (a, b, c, d, e, f)
  tupleZip2 (a, b, c, d, e, f) = (a, (b, c), d, e, f)
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

instance TupleZipper2 (a, (b, c), d, e, f, g) (a, b, c, d, e, f, g) where
  tupleUnzip2 (a, (b, c), d, e, f, g) = (a, b, c, d, e, f, g)
  tupleZip2 (a, b, c, d, e, f, g) = (a, (b, c), d, e, f, g)
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

instance TupleZipper2 (a, (b, c), d, e, f, g, h) (a, b, c, d, e, f, g, h) where
  tupleUnzip2 (a, (b, c), d, e, f, g, h) = (a, b, c, d, e, f, g, h)
  tupleZip2 (a, b, c, d, e, f, g, h) = (a, (b, c), d, e, f, g, h)
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

instance TupleZipper2 (a, (b, c), d, e, f, g, h, i) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip2 (a, (b, c), d, e, f, g, h, i) = (a, b, c, d, e, f, g, h, i)
  tupleZip2 (a, b, c, d, e, f, g, h, i) = (a, (b, c), d, e, f, g, h, i)
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

instance TupleZipper2 (a, (b, c), d, e, f, g, h, i, j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip2 (a, (b, c), d, e, f, g, h, i, j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip2 (a, b, c, d, e, f, g, h, i, j) = (a, (b, c), d, e, f, g, h, i, j)
  {-# INLINEABLE tupleUnzip2 #-}
  {-# INLINEABLE tupleZip2 #-}

class TupleZipper3 t t' | t -> t' where
  {-# MINIMAL tupleUnzip3, tupleZip3 #-}
  tupleUnzip3 :: t -> t'
  tupleZip3 :: t' -> t

instance TupleZipper3 (a, b, (c, d)) (a, b, c, d) where
  tupleUnzip3 (a, b, (c, d)) = (a, b, c, d)
  tupleZip3 (a, b, c, d) = (a, b, (c, d))
  {-# INLINEABLE tupleUnzip3 #-}
  {-# INLINEABLE tupleZip3 #-}

instance TupleZipper3 (a, b, (c, d), e) (a, b, c, d, e) where
  tupleUnzip3 (a, b, (c, d), e) = (a, b, c, d, e)
  tupleZip3 (a, b, c, d, e) = (a, b, (c, d), e)
  {-# INLINEABLE tupleUnzip3 #-}
  {-# INLINEABLE tupleZip3 #-}

instance TupleZipper3 (a, b, (c, d), e, f) (a, b, c, d, e, f) where
  tupleUnzip3 (a, b, (c, d), e, f) = (a, b, c, d, e, f)
  tupleZip3 (a, b, c, d, e, f) = (a, b, (c, d), e, f)
  {-# INLINEABLE tupleUnzip3 #-}
  {-# INLINEABLE tupleZip3 #-}

instance TupleZipper3 (a, b, (c, d), e, f, g) (a, b, c, d, e, f, g) where
  tupleUnzip3 (a, b, (c, d), e, f, g) = (a, b, c, d, e, f, g)
  tupleZip3 (a, b, c, d, e, f, g) = (a, b, (c, d), e, f, g)
  {-# INLINEABLE tupleUnzip3 #-}
  {-# INLINEABLE tupleZip3 #-}

instance TupleZipper3 (a, b, (c, d), e, f, g, h) (a, b, c, d, e, f, g, h) where
  tupleUnzip3 (a, b, (c, d), e, f, g, h) = (a, b, c, d, e, f, g, h)
  tupleZip3 (a, b, c, d, e, f, g, h) = (a, b, (c, d), e, f, g, h)
  {-# INLINEABLE tupleUnzip3 #-}
  {-# INLINEABLE tupleZip3 #-}

instance TupleZipper3 (a, b, (c, d), e, f, g, h, i) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip3 (a, b, (c, d), e, f, g, h, i) = (a, b, c, d, e, f, g, h, i)
  tupleZip3 (a, b, c, d, e, f, g, h, i) = (a, b, (c, d), e, f, g, h, i)
  {-# INLINEABLE tupleUnzip3 #-}
  {-# INLINEABLE tupleZip3 #-}

instance TupleZipper3 (a, b, (c, d), e, f, g, h, i, j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip3 (a, b, (c, d), e, f, g, h, i, j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip3 (a, b, c, d, e, f, g, h, i, j) = (a, b, (c, d), e, f, g, h, i, j)
  {-# INLINEABLE tupleUnzip3 #-}
  {-# INLINEABLE tupleZip3 #-}

class TupleZipper4 t t' | t -> t' where
  {-# MINIMAL tupleUnzip4, tupleZip4 #-}
  tupleUnzip4 :: t -> t'
  tupleZip4 :: t' -> t

instance TupleZipper4 (a, b, c, (d, e)) (a, b, c, d, e) where
  tupleUnzip4 (a, b, c, (d, e)) = (a, b, c, d, e)
  tupleZip4 (a, b, c, d, e) = (a, b, c, (d, e))
  {-# INLINEABLE tupleUnzip4 #-}
  {-# INLINEABLE tupleZip4 #-}

instance TupleZipper4 (a, b, c, (d, e), f) (a, b, c, d, e, f) where
  tupleUnzip4 (a, b, c, (d, e), f) = (a, b, c, d, e, f)
  tupleZip4 (a, b, c, d, e, f) = (a, b, c, (d, e), f)
  {-# INLINEABLE tupleUnzip4 #-}
  {-# INLINEABLE tupleZip4 #-}

instance TupleZipper4 (a, b, c, (d, e), f, g) (a, b, c, d, e, f, g) where
  tupleUnzip4 (a, b, c, (d, e), f, g) = (a, b, c, d, e, f, g)
  tupleZip4 (a, b, c, d, e, f, g) = (a, b, c, (d, e), f, g)
  {-# INLINEABLE tupleUnzip4 #-}
  {-# INLINEABLE tupleZip4 #-}

instance TupleZipper4 (a, b, c, (d, e), f, g, h) (a, b, c, d, e, f, g, h) where
  tupleUnzip4 (a, b, c, (d, e), f, g, h) = (a, b, c, d, e, f, g, h)
  tupleZip4 (a, b, c, d, e, f, g, h) = (a, b, c, (d, e), f, g, h)
  {-# INLINEABLE tupleUnzip4 #-}
  {-# INLINEABLE tupleZip4 #-}

instance TupleZipper4 (a, b, c, (d, e), f, g, h, i) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip4 (a, b, c, (d, e), f, g, h, i) = (a, b, c, d, e, f, g, h, i)
  tupleZip4 (a, b, c, d, e, f, g, h, i) = (a, b, c, (d, e), f, g, h, i)
  {-# INLINEABLE tupleUnzip4 #-}
  {-# INLINEABLE tupleZip4 #-}

instance TupleZipper4 (a, b, c, (d, e), f, g, h, i, j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip4 (a, b, c, (d, e), f, g, h, i, j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip4 (a, b, c, d, e, f, g, h, i, j) = (a, b, c, (d, e), f, g, h, i, j)
  {-# INLINEABLE tupleUnzip4 #-}
  {-# INLINEABLE tupleZip4 #-}

class TupleZipper5 t t' | t -> t' where
  {-# MINIMAL tupleUnzip5, tupleZip5 #-}
  tupleUnzip5 :: t -> t'
  tupleZip5 :: t' -> t

instance TupleZipper5 (a, b, c, d, (e, f)) (a, b, c, d, e, f) where
  tupleUnzip5 (a, b, c, d, (e, f)) = (a, b, c, d, e, f)
  tupleZip5 (a, b, c, d, e, f) = (a, b, c, d, (e, f))
  {-# INLINEABLE tupleUnzip5 #-}
  {-# INLINEABLE tupleZip5 #-}

instance TupleZipper5 (a, b, c, d, (e, f), g) (a, b, c, d, e, f, g) where
  tupleUnzip5 (a, b, c, d, (e, f), g) = (a, b, c, d, e, f, g)
  tupleZip5 (a, b, c, d, e, f, g) = (a, b, c, d, (e, f), g)
  {-# INLINEABLE tupleUnzip5 #-}
  {-# INLINEABLE tupleZip5 #-}

instance TupleZipper5 (a, b, c, d, (e, f), g, h) (a, b, c, d, e, f, g, h) where
  tupleUnzip5 (a, b, c, d, (e, f), g, h) = (a, b, c, d, e, f, g, h)
  tupleZip5 (a, b, c, d, e, f, g, h) = (a, b, c, d, (e, f), g, h)
  {-# INLINEABLE tupleUnzip5 #-}
  {-# INLINEABLE tupleZip5 #-}

instance TupleZipper5 (a, b, c, d, (e, f), g, h, i) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip5 (a, b, c, d, (e, f), g, h, i) = (a, b, c, d, e, f, g, h, i)
  tupleZip5 (a, b, c, d, e, f, g, h, i) = (a, b, c, d, (e, f), g, h, i)
  {-# INLINEABLE tupleUnzip5 #-}
  {-# INLINEABLE tupleZip5 #-}

instance TupleZipper5 (a, b, c, d, (e, f), g, h, i, j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip5 (a, b, c, d, (e, f), g, h, i, j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip5 (a, b, c, d, e, f, g, h, i, j) = (a, b, c, d, (e, f), g, h, i, j)
  {-# INLINEABLE tupleUnzip5 #-}
  {-# INLINEABLE tupleZip5 #-}

class TupleZipper6 t t' | t -> t' where
  {-# MINIMAL tupleUnzip6, tupleZip6 #-}
  tupleUnzip6 :: t -> t'
  tupleZip6 :: t' -> t

instance TupleZipper6 (a, b, c, d, e, (f, g)) (a, b, c, d, e, f, g) where
  tupleUnzip6 (a, b, c, d, e, (f, g)) = (a, b, c, d, e, f, g)
  tupleZip6 (a, b, c, d, e, f, g) = (a, b, c, d, e, (f, g))
  {-# INLINEABLE tupleUnzip6 #-}
  {-# INLINEABLE tupleZip6 #-}

instance TupleZipper6 (a, b, c, d, e, (f, g), h) (a, b, c, d, e, f, g, h) where
  tupleUnzip6 (a, b, c, d, e, (f, g), h) = (a, b, c, d, e, f, g, h)
  tupleZip6 (a, b, c, d, e, f, g, h) = (a, b, c, d, e, (f, g), h)
  {-# INLINEABLE tupleUnzip6 #-}
  {-# INLINEABLE tupleZip6 #-}

instance TupleZipper6 (a, b, c, d, e, (f, g), h, i) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip6 (a, b, c, d, e, (f, g), h, i) = (a, b, c, d, e, f, g, h, i)
  tupleZip6 (a, b, c, d, e, f, g, h, i) = (a, b, c, d, e, (f, g), h, i)
  {-# INLINEABLE tupleUnzip6 #-}
  {-# INLINEABLE tupleZip6 #-}

instance TupleZipper6 (a, b, c, d, e, (f, g), h, i, j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip6 (a, b, c, d, e, (f, g), h, i, j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip6 (a, b, c, d, e, f, g, h, i, j) = (a, b, c, d, e, (f, g), h, i, j)
  {-# INLINEABLE tupleUnzip6 #-}
  {-# INLINEABLE tupleZip6 #-}

class TupleZipper7 t t' | t -> t' where
  {-# MINIMAL tupleUnzip7, tupleZip7 #-}
  tupleUnzip7 :: t -> t'
  tupleZip7 :: t' -> t

instance TupleZipper7 (a, b, c, d, e, f, (g, h)) (a, b, c, d, e, f, g, h) where
  tupleUnzip7 (a, b, c, d, e, f, (g, h)) = (a, b, c, d, e, f, g, h)
  tupleZip7 (a, b, c, d, e, f, g, h) = (a, b, c, d, e, f, (g, h))
  {-# INLINEABLE tupleUnzip7 #-}
  {-# INLINEABLE tupleZip7 #-}

instance TupleZipper7 (a, b, c, d, e, f, (g, h), i) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip7 (a, b, c, d, e, f, (g, h), i) = (a, b, c, d, e, f, g, h, i)
  tupleZip7 (a, b, c, d, e, f, g, h, i) = (a, b, c, d, e, f, (g, h), i)
  {-# INLINEABLE tupleUnzip7 #-}
  {-# INLINEABLE tupleZip7 #-}

instance TupleZipper7 (a, b, c, d, e, f, (g, h), i, j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip7 (a, b, c, d, e, f, (g, h), i, j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip7 (a, b, c, d, e, f, g, h, i, j) = (a, b, c, d, e, f, (g, h), i, j)
  {-# INLINEABLE tupleUnzip7 #-}
  {-# INLINEABLE tupleZip7 #-}

class TupleZipper8 t t' | t -> t' where
  {-# MINIMAL tupleUnzip8, tupleZip8 #-}
  tupleUnzip8 :: t -> t'
  tupleZip8 :: t' -> t

instance TupleZipper8 (a, b, c, d, e, f, g, (h, i)) (a, b, c, d, e, f, g, h, i) where
  tupleUnzip8 (a, b, c, d, e, f, g, (h, i)) = (a, b, c, d, e, f, g, h, i)
  tupleZip8 (a, b, c, d, e, f, g, h, i) = (a, b, c, d, e, f, g, (h, i))
  {-# INLINEABLE tupleUnzip8 #-}
  {-# INLINEABLE tupleZip8 #-}

instance TupleZipper8 (a, b, c, d, e, f, g, (h, i), j) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip8 (a, b, c, d, e, f, g, (h, i), j) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip8 (a, b, c, d, e, f, g, h, i, j) = (a, b, c, d, e, f, g, (h, i), j)
  {-# INLINEABLE tupleUnzip8 #-}
  {-# INLINEABLE tupleZip8 #-}

class TupleZipper9 t t' | t -> t' where
  {-# MINIMAL tupleUnzip9, tupleZip9 #-}
  tupleUnzip9 :: t -> t'
  tupleZip9 :: t' -> t

instance TupleZipper9 (a, b, c, d, e, f, g, h, (i, j)) (a, b, c, d, e, f, g, h, i, j) where
  tupleUnzip9 (a, b, c, d, e, f, g, h, (i, j)) = (a, b, c, d, e, f, g, h, i, j)
  tupleZip9 (a, b, c, d, e, f, g, h, i, j) = (a, b, c, d, e, f, g, h, (i, j))
  {-# INLINEABLE tupleUnzip9 #-}
  {-# INLINEABLE tupleZip9 #-}