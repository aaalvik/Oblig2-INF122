{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Oblig2_INF122 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/pokki/.cabal/bin"
libdir     = "/Users/pokki/.cabal/lib/x86_64-osx-ghc-8.4.3/Oblig2-INF122-0.1.0.0-AUtC6aWrdvuFaIFmYrCKhG"
dynlibdir  = "/Users/pokki/.cabal/lib/x86_64-osx-ghc-8.4.3"
datadir    = "/Users/pokki/.cabal/share/x86_64-osx-ghc-8.4.3/Oblig2-INF122-0.1.0.0"
libexecdir = "/Users/pokki/.cabal/libexec/x86_64-osx-ghc-8.4.3/Oblig2-INF122-0.1.0.0"
sysconfdir = "/Users/pokki/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Oblig2_INF122_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Oblig2_INF122_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Oblig2_INF122_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Oblig2_INF122_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Oblig2_INF122_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Oblig2_INF122_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
