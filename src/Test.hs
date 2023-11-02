{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
module Test
  ( fastSin
  , c_libinput_device_tablet_pad_get_num_mode_groups
  , ConfigStatus
      ( StatusSuccess 
      , StatusUnsupported
      , StatusInvalid )
  )
where

import Data.Bits ((.&.), (.|.))
import Data.ByteString.Unsafe (unsafePackCString)
import Data.Text (Text)
import Data.Word (Word32)
import Foreign.C.Error (throwErrnoIfNull)
import Foreign.C.String (CString)
import Foreign.C.Types
import Foreign.Marshal.Alloc
import Foreign.Ptr (Ptr, nullPtr)
import Foreign.Storable

import qualified Data.Text as T
import qualified Data.Text.Encoding as E

-- math.h FFI Testing -------------------------------------------------------
foreign import capi "math.h sin"
  c_sin :: CDouble -> CDouble
fastSin :: Double -> Double
fastSin x = realToFrac (c_sin (realToFrac x))

-----------------------------------------------------------------------------
-- libinput.h FFI Testing ---------------------------------------------------

newtype InputDevice = InputDevice { unID :: Ptr InputDevice }
  deriving
    ( Eq
    , Show )

newtype InputDeviceGroup = InputDeviceGroup ( Ptr InputDeviceGroup )
  deriving
    ( Eq
    , Show )

foreign import capi unsafe "libinput.h libinput_device_tablet_pad_get_num_mode_groups"
  c_libinput_device_tablet_pad_get_num_mode_groups :: Ptr InputDevice -> IO CInt
-- tabletPadGetNumModeGroups :: InputDevice -> Int
-- tabletPadGetNumModeGroups = c_libinput_device_tablet_pad_get_num_mode_groups

data ConfigStatus
    = StatusSuccess
    | StatusUnsupported
    | StatusInvalid
    deriving
      ( Eq
      , Show
      , Read )
-----------------------------------------------------------------------------