/* =========================================================================
 * $Id$
 *
 * geos.i
 * 
 * Copyright 2004 Sean Gillies, sgillies@frii.com
 *
 * Interface for a SWIG generated geos module.
 *
 * This is free software; you can redistribute and/or modify it under
 * the terms of the GNU Lesser General Public Licence as published
 * by the Free Software Foundation. 
 * See the COPYING file for more information.
 *
 * ========================================================================= */
 
%module geos
%include "std_string.i"
%include "std_vector.i"
%include "exception.i"

%{ 
#include "../../source/headers/geos.h"
#include "../../source/headers/geos/opLinemerge.h"
#include "../../source/headers/geos/opPolygonize.h"
%}

// Following methods are prototypes but unimplemented and are to be ignored
%ignore geos::MultiPoint::isClosed;

%apply SWIGTYPE *DISOWN { geos::CoordinateSequence * };
%apply SWIGTYPE *DISOWN { geos::LinearRing * };
%apply SWIGTYPE *DISOWN { std::vector<geos::Geometry * > * };

// no transfer of ownership
%ignore geos::GeometryFactory::createPoint(CoordinateSequence *) const;
%rename(createLineStringP) geos::GeometryFactory::createLineString(CoordinateSequence *) const;
%rename(createLinearRingP) geos::GeometryFactory::createLinearRing(CoordinateSequence *) const;
%rename(createPolygonPP) geos::GeometryFactory::createPolygon(LinearRing *,vector<Geometry * > *) const;
%ignore geos::GeometryFactory::createGeometryCollection(vector<Geometry * > *) const;
%ignore geos::GeometryFactory::buildGeometry(vector<Geometry * > *) const;
%ignore geos::GeometryFactory::createMultiPoint(vector<Geometry * > *) const;
%ignore geos::GeometryFactory::createMultiLineString(vector<Geometry * > *) const;
%ignore geos::GeometryFactory::createMultiLinearRing(vector<Geometry * > *) const;
%ignore geos::GeometryFactory::createMultiPolygon(vector<Geometry * > *) const;

// Required renaming
%rename(Coordinate_Coordinate) Coordinate::Coordinate;

%exception {
    try {
        $action
    }
    catch (geos::GEOSException *e) {
        SWIG_exception(SWIG_RuntimeError, e->toString().data());
    }
}


// Now include the headers to be wrapped
%include "../../source/headers/geos/geom.h"
%include "../../source/headers/geos/util.h"
%include "../../source/headers/geos/io.h"


%ignore geos::LineMergeDirectedEdge;
%ignore geos::PolygonizeEdge;
%ignore geos::polygonizeEdgeRing;
%ignore geos::PolygonizeDirectedEdge;
%ignore geos::PolygonizeGraph;

%include "../../source/headers/geos/opLinemerge.h"
%include "../../source/headers/geos/opPolygonize.h"

//~ template<class T> 
//~ class vector {
//~ public:
    //~ vector();
    //~ ~vector();
    //~ void push_back(const T obj);
    //~ void reserve(size_t n);
//~ };

%template(vector_GeometryP) std::vector<geos::Geometry *>;
%template(vector_LineStringP) std::vector<geos::LineString *>;
%template(vector_PolygonP) std::vector<geos::Polygon *>;
