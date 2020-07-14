/*
 * Note: this file originally auto-generated by mib2c using
 *        : mib2c.scalar.conf 17337 2009-01-01 14:28:29Z magfr $
 */

#include <net-snmp/net-snmp-config.h>
#include <net-snmp/net-snmp-includes.h>
#include <net-snmp/agent/net-snmp-agent-includes.h>
#include "netSnmpValueTest.h"

#include <arpa/inet.h>
#include <stdlib.h>


#undef INCLUDE_DEPRECATED_TYPES


/** Initializes the netSnmpValueTest module */
void
init_netSnmpValueTest(void)
{
    const oid       netSnmpValueTestInteger32_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 1 };
    const oid       netSnmpValueTestGauge_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 2 };
    const oid       netSnmpValueTestCounter_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 3 };
    const oid       netSnmpValueTestCounter64_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 4 };
    const oid       netSnmpValueTestTimeticks_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 5 };
    const oid       netSnmpValueTestUnsigned32_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 6 };
    const oid       netSnmpValueTestIpAddress_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 7 };
    const oid       netSnmpValueTestOpaque_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 8 };
    const oid       netSnmpValueTestObjectID_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 9 };
    const oid       netSnmpValueTestBitString_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 10 };
    const oid       netSnmpValueTestOctetString_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 11 };
    const oid       netSnmpValueTestOpaqueCounter64_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 12 };
    const oid       netSnmpValueTestOpaqueU64_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 13 };
    const oid       netSnmpValueTestOpaqueI64_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 14 };
    const oid       netSnmpValueTestOpaqueFloat_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 15 };
    const oid       netSnmpValueTestOpaqueDouble_oid[] =
        { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 16 };

    DEBUGMSGTL(("netSnmpValueTest", "Initializing\n"));

    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestInteger32",
                             handle_netSnmpValueTestInteger32,
                             netSnmpValueTestInteger32_oid,
                             OID_LENGTH(netSnmpValueTestInteger32_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestGauge",
                             handle_netSnmpValueTestGauge,
                             netSnmpValueTestGauge_oid,
                             OID_LENGTH(netSnmpValueTestGauge_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestCounter",
                             handle_netSnmpValueTestCounter,
                             netSnmpValueTestCounter_oid,
                             OID_LENGTH(netSnmpValueTestCounter_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestCounter64",
                             handle_netSnmpValueTestCounter64,
                             netSnmpValueTestCounter64_oid,
                             OID_LENGTH(netSnmpValueTestCounter64_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestTimeticks",
                             handle_netSnmpValueTestTimeticks,
                             netSnmpValueTestTimeticks_oid,
                             OID_LENGTH(netSnmpValueTestTimeticks_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestUnsigned32",
                             handle_netSnmpValueTestUnsigned32,
                             netSnmpValueTestUnsigned32_oid,
                             OID_LENGTH(netSnmpValueTestUnsigned32_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestIpAddress",
                             handle_netSnmpValueTestIpAddress,
                             netSnmpValueTestIpAddress_oid,
                             OID_LENGTH(netSnmpValueTestIpAddress_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestOpaque",
                             handle_netSnmpValueTestOpaque,
                             netSnmpValueTestOpaque_oid,
                             OID_LENGTH(netSnmpValueTestOpaque_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestObjectID",
                             handle_netSnmpValueTestObjectID,
                             netSnmpValueTestObjectID_oid,
                             OID_LENGTH(netSnmpValueTestObjectID_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestBitString",
                             handle_netSnmpValueTestBitString,
                             netSnmpValueTestBitString_oid,
                             OID_LENGTH(netSnmpValueTestBitString_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestOctetString",
                             handle_netSnmpValueTestOctetString,
                             netSnmpValueTestOctetString_oid,
                             OID_LENGTH(netSnmpValueTestOctetString_oid),
                             HANDLER_CAN_RONLY));
#ifdef INCLUDE_DEPRECATED_TYPES
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestOpaqueCounter64",
                             handle_netSnmpValueTestOpaqueCounter64,
                             netSnmpValueTestOpaqueCounter64_oid,
                             OID_LENGTH
                             (netSnmpValueTestOpaqueCounter64_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestOpaqueU64",
                             handle_netSnmpValueTestOpaqueU64,
                             netSnmpValueTestOpaqueU64_oid,
                             OID_LENGTH(netSnmpValueTestOpaqueU64_oid),
                             HANDLER_CAN_RONLY));
#endif /* INCLUDE_DEPRECATED_TYPES */
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestOpaqueI64",
                             handle_netSnmpValueTestOpaqueI64,
                             netSnmpValueTestOpaqueI64_oid,
                             OID_LENGTH(netSnmpValueTestOpaqueI64_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestOpaqueFloat",
                             handle_netSnmpValueTestOpaqueFloat,
                             netSnmpValueTestOpaqueFloat_oid,
                             OID_LENGTH(netSnmpValueTestOpaqueFloat_oid),
                             HANDLER_CAN_RONLY));
    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("netSnmpValueTestOpaqueDouble",
                             handle_netSnmpValueTestOpaqueDouble,
                             netSnmpValueTestOpaqueDouble_oid,
                             OID_LENGTH(netSnmpValueTestOpaqueDouble_oid),
                             HANDLER_CAN_RONLY));
}

static int asn_integer_val = 42;

handle_netSnmpValueTestInteger32(netsnmp_mib_handler *handler,
                                 netsnmp_handler_registration *reginfo,
                                 netsnmp_agent_request_info *reqinfo,
                                 netsnmp_request_info *requests)
{
    /*
     * We are never called for a GETNEXT if it's registered as a
     * "instance", as it's "magically" handled for us.  
     */

    /*
     * a instance handler also only hands us one request at a time, so
     * we don't need to loop over a list of requests; we'll only get one. 
     */

    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_INTEGER,
                                 (u_char *) &asn_integer_val, sizeof asn_integer_val);
        break;

    default:
        /*
         * we should never get here, so this is a really bad error 
         */
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestInteger32\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static unsigned int asn_gauge_val = 43;

int
handle_netSnmpValueTestGauge(netsnmp_mib_handler *handler,
                             netsnmp_handler_registration *reginfo,
                             netsnmp_agent_request_info *reqinfo,
                             netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_GAUGE,
                                 (u_char *) &asn_gauge_val, sizeof asn_gauge_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestGauge\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static unsigned int asn_counter_val = 0xdeadbeef;

int
handle_netSnmpValueTestCounter(netsnmp_mib_handler *handler,
                               netsnmp_handler_registration *reginfo,
                               netsnmp_agent_request_info *reqinfo,
                               netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_COUNTER,
                                 (u_char *) &asn_counter_val, sizeof asn_counter_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestCounter\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

struct counter64 asn_counter64_val = { .high = 0xcafebabe, .low = 0xdeadbeef };

int
handle_netSnmpValueTestCounter64(netsnmp_mib_handler *handler,
                                 netsnmp_handler_registration *reginfo,
                                 netsnmp_agent_request_info *reqinfo,
                                 netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_COUNTER64,
                                 (u_char *) &asn_counter64_val, sizeof asn_counter64_val);
        break;

    default:
        /*
         * we should never get here, so this is a really bad error 
         */
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestCounter64\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static unsigned int asn_timeticks_val = 0xbabebeef;

int
handle_netSnmpValueTestTimeticks(netsnmp_mib_handler *handler,
                                 netsnmp_handler_registration *reginfo,
                                 netsnmp_agent_request_info *reqinfo,
                                 netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_TIMETICKS,
                                 (u_char *) &asn_timeticks_val, sizeof asn_timeticks_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestTimeticks\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static unsigned int asn_unsigned32_val = 0xcafebabe;

int
handle_netSnmpValueTestUnsigned32(netsnmp_mib_handler *handler,
                                  netsnmp_handler_registration *reginfo,
                                  netsnmp_agent_request_info *reqinfo,
                                  netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_UNSIGNED,
                                 (u_char *) &asn_unsigned32_val, sizeof asn_unsigned32_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestUnsigned32\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static struct in_addr asn_ipaddress_val;

int
handle_netSnmpValueTestIpAddress(netsnmp_mib_handler *handler,
                                 netsnmp_handler_registration *reginfo,
                                 netsnmp_agent_request_info *reqinfo,
                                 netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        inet_aton("1.2.3.4", &asn_ipaddress_val);
        snmp_set_var_typed_value(requests->requestvb, ASN_IPADDRESS,
                                 (u_char *)&asn_ipaddress_val, sizeof asn_ipaddress_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestIpAddress\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static char asn_opaque_val[] = "OpaqueValue";

int
handle_netSnmpValueTestOpaque(netsnmp_mib_handler *handler,
                              netsnmp_handler_registration *reginfo,
                              netsnmp_agent_request_info *reqinfo,
                              netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OPAQUE,
                                 (u_char *)asn_opaque_val, strlen(asn_opaque_val) + 1);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestOpaque\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

const oid asn_object_id_val[] = { 1, 3, 6, 1, 4, 1, 8072, 2, 99, 9 };

int
handle_netSnmpValueTestObjectID(netsnmp_mib_handler *handler,
                                netsnmp_handler_registration *reginfo,
                                netsnmp_agent_request_info *reqinfo,
                                netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OBJECT_ID,
                                 (u_char *)asn_object_id_val, sizeof asn_object_id_val);
        break;


    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestObjectID\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static u_char asn_bits_val[] = { 0b10011001, 0b11001100 };

int
handle_netSnmpValueTestBitString(netsnmp_mib_handler *handler,
                                 netsnmp_handler_registration *reginfo,
                                 netsnmp_agent_request_info *reqinfo,
                                 netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_BIT_STR,
                                 (u_char *)asn_bits_val, (sizeof asn_bits_val)/(sizeof (u_char)));
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestBitString\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static char asn_octet_string_val[] = "asn_octet_string_val";

int
handle_netSnmpValueTestOctetString(netsnmp_mib_handler *handler,
                                   netsnmp_handler_registration *reginfo,
                                   netsnmp_agent_request_info *reqinfo,
                                   netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OCTET_STR,
                                 (u_char *)asn_octet_string_val, sizeof asn_octet_string_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestOctetString\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

#ifdef NETSNMP_WITH_OPAQUE_SPECIAL_TYPES

struct counter64 asn_opaque_counter64_val = { .high = 0xdeadbeef, .low = 0xcafebabe };

int
handle_netSnmpValueTestOpaqueCounter64(netsnmp_mib_handler *handler,
                                       netsnmp_handler_registration
                                       *reginfo,
                                       netsnmp_agent_request_info *reqinfo,
                                       netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OPAQUE_COUNTER64,
                                 (u_char *)&asn_opaque_counter64_val, sizeof asn_opaque_counter64_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestOpaqueCounter64\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

struct counter64 asn_opaque_u64_val = { .high = 0xdeadcafe, .low = 0xbeefbabe };

int
handle_netSnmpValueTestOpaqueU64(netsnmp_mib_handler *handler,
                                 netsnmp_handler_registration *reginfo,
                                 netsnmp_agent_request_info *reqinfo,
                                 netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OPAQUE_U64,
                                 (u_char *)&asn_opaque_u64_val, sizeof asn_opaque_u64_val);
        break;


    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestOpaqueU64\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

struct counter64 asn_opaque_i64_val = { .high = 0x0000cafe, .low = 0xbabe0000 };

int
handle_netSnmpValueTestOpaqueI64(netsnmp_mib_handler *handler,
                                 netsnmp_handler_registration *reginfo,
                                 netsnmp_agent_request_info *reqinfo,
                                 netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OPAQUE_I64,
                                 (u_char *)&asn_opaque_i64_val, sizeof asn_opaque_i64_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestOpaqueI64\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static float asn_float_val = 3.1415927f;

int
handle_netSnmpValueTestOpaqueFloat(netsnmp_mib_handler *handler,
                                   netsnmp_handler_registration *reginfo,
                                   netsnmp_agent_request_info *reqinfo,
                                   netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OPAQUE_FLOAT,
                                 (u_char *)&asn_float_val, sizeof asn_float_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestOpaqueFloat\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

static double asn_double_val = 3.1415926535897931;

int
handle_netSnmpValueTestOpaqueDouble(netsnmp_mib_handler *handler,
                                    netsnmp_handler_registration *reginfo,
                                    netsnmp_agent_request_info *reqinfo,
                                    netsnmp_request_info *requests)
{
    switch (reqinfo->mode) {

    case MODE_GET:
        snmp_set_var_typed_value(requests->requestvb, ASN_OPAQUE_DOUBLE,
                                 (u_char *)&asn_double_val, sizeof asn_double_val);
        break;

    default:
        snmp_log(LOG_ERR,
                 "unknown mode (%d) in handle_netSnmpValueTestOpaqueDouble\n",
                 reqinfo->mode);
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}

#endif
