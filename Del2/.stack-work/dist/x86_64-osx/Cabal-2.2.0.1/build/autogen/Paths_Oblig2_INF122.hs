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

bindir     = "/Users/pokki/Documents/workspace/Masteroppgaven-workspace/Oblig2-INF122/Oppgave2/.stack-work/install/x86_64-osx/lts-12.14/8.4.3/bin"
libdir     = "/Users/pokki/Documents/workspace/Masteroppgaven-workspace/Oblig2-INF122/Oppgave2/.stack-work/install/x86_64-osx/lts-12.14/8.4.3/lib/x86_64-osx-ghc-8.4.3/Oblig2-INF122-0.1.0.0-8cpJ2QxhiFI3jrCtHwoMCS"
dynlibdir  = "/Users/pokki/Documents/workspace/Masteroppgaven-workspace/Oblig2-INF122/Oppgave2/.stack-work/install/x86_64-osx/lts-12.14/8.4.3/lib/x86_64-osx-ghc-8.4.3"
datadir    = "/Users/pokki/Documents/workspace/Masteroppgaven-workspace/Oblig2-INF122/Oppgave2/.stack-work/install/x86_64-osx/lts-12.14/8.4.3/share/x86_64-osx-ghc-8.4.3/Oblig2-INF122-0.1.0.0"
libexecdir = "/Users/pokki/Documents/workspace/Masteroppgaven-workspace/Oblig2-INF122/Oppgave2/.stack-work/install/x86_64-osx/lts-12.14/8.4.3/libexec/x86_64-osx-ghc-8.4.3/Oblig2-INF122-0.1.0.0"
sysconfdir = "/Users/pokki/Documents/workspace/Masteroppgaven-workspace/Oblig2-INF122/Oppgave2/.stack-work/install/x86_64-osx/lts-12.14/8.4.3/etc"

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
