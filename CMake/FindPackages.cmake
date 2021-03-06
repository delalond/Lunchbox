# generated by Buildyard, do not edit.

include(System)
list(APPEND FIND_PACKAGES_DEFINES ${SYSTEM})

find_package(hwloc 1.5)
if(hwloc_FOUND)
  set(hwloc_name hwloc)
endif()
if(HWLOC_FOUND)
  set(hwloc_name HWLOC)
endif()
if(hwloc_name)
  list(APPEND FIND_PACKAGES_DEFINES LUNCHBOX_USE_HWLOC)
  link_directories(${${hwloc_name}_LIBRARY_DIRS})
  include_directories(${${hwloc_name}_INCLUDE_DIRS})
endif()

find_package(DNSSD )
if(DNSSD_FOUND)
  set(DNSSD_name DNSSD)
endif()
if(DNSSD_FOUND)
  set(DNSSD_name DNSSD)
endif()
if(DNSSD_name)
  list(APPEND FIND_PACKAGES_DEFINES LUNCHBOX_USE_DNSSD)
  link_directories(${${DNSSD_name}_LIBRARY_DIRS})
  include_directories(${${DNSSD_name}_INCLUDE_DIRS})
endif()

find_package(Boost 1.41.0 REQUIRED regex serialization)
if(Boost_FOUND)
  set(Boost_name Boost)
endif()
if(BOOST_FOUND)
  set(Boost_name BOOST)
endif()
if(Boost_name)
  list(APPEND FIND_PACKAGES_DEFINES LUNCHBOX_USE_BOOST)
  link_directories(${${Boost_name}_LIBRARY_DIRS})
  include_directories(SYSTEM ${${Boost_name}_INCLUDE_DIRS})
endif()


set(LUNCHBOX_DEPENDS hwloc;DNSSD;Boost)

# Write defines.h and options.cmake
if(NOT FIND_PACKAGES_INCLUDE)
  set(FIND_PACKAGES_INCLUDE
    "${CMAKE_BINARY_DIR}/include/${CMAKE_PROJECT_NAME}/defines${SYSTEM}.h")
endif()
if(NOT OPTIONS_CMAKE)
  set(OPTIONS_CMAKE ${CMAKE_BINARY_DIR}/options.cmake)
endif()
set(DEFINES_FILE ${FIND_PACKAGES_INCLUDE})
set(DEFINES_FILE_IN ${DEFINES_FILE}.in)
file(WRITE ${DEFINES_FILE_IN}
  "// generated by Buildyard, do not edit.\n\n"
  "#ifndef ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n"
  "#define ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n\n")
file(WRITE ${OPTIONS_CMAKE} "# Optional modules enabled during build\n")
foreach(DEF ${FIND_PACKAGES_DEFINES})
  add_definitions(-D${DEF})
  file(APPEND ${DEFINES_FILE_IN}
  "#ifndef ${DEF}\n"
  "#  define ${DEF}\n"
  "#endif\n")
if(NOT DEF STREQUAL SYSTEM)
  file(APPEND ${OPTIONS_CMAKE} "set(${DEF} ON)\n")
endif()
endforeach()
file(APPEND ${DEFINES_FILE_IN}
  "\n#endif\n")

include(UpdateFile)
update_file(${DEFINES_FILE_IN} ${DEFINES_FILE})
