# @mason: flutter_rust_bridge
# We include Corrosion inline here, but ideally in a project with
# many dependencies we would need to install Corrosion on the system.
# See instructions on https://github.com/AndrewGaspar/corrosion#cmake-install
# Once done, uncomment this line:
# find_package(Corrosion REQUIRED)

include(FetchContent)
FetchContent_Declare(
    Corrosion
    # SOURCE_DIR ../corrosion
    # add_subdirectory(../corrosion)
    GIT_REPOSITORY https://gitee.com/guchengxi1994/corrosion
    GIT_TAG origin/master # Optionally specify a version tag or branch here
)

FetchContent_MakeAvailable(Corrosion)

corrosion_import_crate(MANIFEST_PATH ../native/Cargo.toml)

# Flutter-specific

set(CRATE_NAME "native")

target_link_libraries(${BINARY_NAME} PRIVATE ${CRATE_NAME})

list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${CRATE_NAME}-shared>)

