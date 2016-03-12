
This modules loads images into GPipe.

> {-# LANGUAGE ScopedTypeVariables, PackageImports, FlexibleContexts, TypeFamilies #-}
> module Textures where

Textures are stored in the data directory, which can be found using
the cabal-generated Path_gpipe_hello module.

> import Paths_gpipe_hello (getDataDir)
> import System.FilePath ((</>))
> import qualified "JuicyPixels" Codec.Picture as Juicy
> import qualified "JuicyPixels" Codec.Picture.Types as Juicy
> import "transformers" Control.Monad.IO.Class
> import "linear" Linear (V2(..),V3(..))
> import Graphics.GPipe ( newTexture2D, writeTexture2D
>                       , generateTexture2DMipmap
>                       , Format(SRGB8), ContextT, Texture2D, RGBFloat
>                       )

> load :: MonadIO m => FilePath -> ContextT w os f m (Texture2D os (Format RGBFloat))
> load name = do
>     dataDir <- liftIO $ getDataDir
>     let filename = dataDir </> name
>     liftIO $ putStrLn $ "Loading image " ++ filename
>     result <- liftIO $ Juicy.readImage filename
>     let image = case result of
>                   Right (Juicy.ImageYCbCr8 i) -> i
>                   Right x -> error $ "Image was not in expected format"
>                   Left e -> error $ "Could not load image: " ++ show e
>     let size = V2 (Juicy.imageWidth image) (Juicy.imageHeight (image))
>     tex <- newTexture2D SRGB8 size maxBound -- JPG converts to SRGB
>     writeTexture2D tex 0 0 size $ Juicy.pixelFold getJuicyPixel [] image
>     generateTexture2DMipmap tex
>     return tex

> getJuicyPixel xs _x _y pix =
>   let Juicy.PixelRGB8 r g b = Juicy.convertPixel pix in V3 r g b : xs
