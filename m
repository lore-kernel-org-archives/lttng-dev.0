From: oliviercotte <jonathan.r.julien@gmail.com>
Subject: [MI RFC 3/3] Mi: xsd for validation of mi ouput
Date: Sun, 6 Apr 2014 15:32:03 -0400
Message-ID: <20140406193203.GA25274__43843.7002747834$1396813086$gmane$org@psrcode-MS-7693>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1WWsna-0001mY-DS
 for lttng-dev@lists.lttng.org; Sun, 06 Apr 2014 15:32:22 -0400
Received: by mail-qc0-f174.google.com with SMTP id c9so5586048qcz.33
 for <lttng-dev@lists.lttng.org>; Sun, 06 Apr 2014 12:32:05 -0700 (PDT)
Received: from psrcode-MS-7693 (cable-28.246.173-253.electronicbox.net.
 [173.246.28.253])
 by mx.google.com with ESMTPSA id 65sm20125698qgj.20.2014.04.06.12.32.04
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Sun, 06 Apr 2014 12:32:04 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Support command version and list

Signed-off-by: Olivier Cotte <olivier.cotte@polymtl.ca>
Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
---
 src/common/mi_lttng.xsd | 322 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 322 insertions(+)
 create mode 100644 src/common/mi_lttng.xsd

diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
new file mode 100644
index 0000000..1cf935b
--- /dev/null
+++ b/src/common/mi_lttng.xsd
@@ -0,0 +1,322 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
+	elementFormDefault="qualified" version="2.5">
+
+	<!-- Maps to the uint32_t type -->
+	<xs:simpleType name="uint32_type">
+		<xs:restriction base="xs:integer">
+			<xs:minInclusive value="0" />
+			<xs:maxInclusive value="4294967295" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the uint64_t type -->
+	<xs:simpleType name="uint64_type">
+		<xs:restriction base="xs:integer">
+			<xs:minInclusive value="0" />
+			<xs:maxInclusive value="18446744073709551615" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the char name[LTTNG_SYMBOL_NAME_LEN] -->
+	<xs:simpleType name="name_type">
+		<xs:restriction base="xs:string">
+			<xs:maxLength value="255" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the lttng_event_type enum -->
+	<xs:simpleType name="event_type_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="ALL" />
+			<xs:enumeration value="TRACEPOINT" />
+			<xs:enumeration value="PROBE" />
+			<xs:enumeration value="FUNCTION" />
+			<xs:enumeration value="FUNCTION_ENTRY" />
+			<xs:enumeration value="NOOP" />
+			<xs:enumeration value="SYSCALL" />
+			<xs:enumeration value="KPROBE" />
+			<xs:enumeration value="KRETPROBE" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the lttng_event_field_type enum -->
+	<xs:simpleType name="event_field_type_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="OTHER" />
+			<xs:enumeration value="INTEGER" />
+			<xs:enumeration value="ENUM" />
+			<xs:enumeration value="FLOAT" />
+			<xs:enumeration value="STRING" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the lttng_loglevel_type enum -->
+	<xs:simpleType name="loglevel_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="ALL" />
+			<xs:enumeration value="RANGE" />
+			<xs:enumeration value="SINGLE" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to loglevel_string char * -->
+	<xs:simpleType name="loglevel_string_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="" />
+			<xs:enumeration value="TRACE_EMERG" />
+			<xs:enumeration value="TRACE_ALERT" />
+			<xs:enumeration value="TRACE_CRIT" />
+			<xs:enumeration value="TRACE_ERR" />
+			<xs:enumeration value="TRACE_WARNING" />
+			<xs:enumeration value="TRACE_NOTICE" />
+			<xs:enumeration value="TRACE_INFO" />
+			<xs:enumeration value="TRACE_DEBUG_SYSTEM" />
+			<xs:enumeration value="TRACE_DEBUG_PROGRAM" />
+			<xs:enumeration value="TRACE_DEBUG_PROCESS" />
+			<xs:enumeration value="TRACE_DEBUG_MODULE" />
+			<xs:enumeration value="TRACE_DEBUG_UNIT" />
+			<xs:enumeration value="TRACE_DEBUG_FUNCTION" />
+			<xs:enumeration value="TRACE_DEBUG_LINE" />
+			<xs:enumeration value="TRACE_DEBUG" />
+			<xs:enumeration value="UNKNOWN" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the enable_string char * -->
+	<xs:simpleType name="enable_string_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="" />
+			<xs:enumeration value=" [disabled]" />
+			<xs:enumeration value=" [enabled]" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the filter_string char * -->
+	<xs:simpleType name="filter_string_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="" />
+			<xs:enumeration value=" [with filter]" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the exclusion_string char * -->
+	<xs:simpleType name="exclusion_string_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="" />
+			<xs:enumeration value=" [has exclusions]" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the lttng_event_probe_attr struct -->
+	<xs:complexType name="event_probe_attributes_type">
+		<xs:all>
+			<xs:element name="address" type="uint64_type" />
+			<xs:element name="offset" type="uint64_type" />
+			<xs:element name="symbol_name" type="name_type" />
+		</xs:all>
+	</xs:complexType>
+
+	<!-- Maps to the lttng_event_function_attr struct -->
+	<xs:complexType name="event_ftrace_attributes_type">
+		<xs:all>
+			<xs:element name="symbol_name" type="name_type" />
+		</xs:all>
+	</xs:complexType>
+
+	<!-- Maps to per event type configuration -->
+	<xs:complexType name="event_attributes_type">
+		<xs:choice>
+			<xs:element name="probe_attributes" type="event_probe_attributes_type" />
+			<xs:element name="function_attributes" type="event_ftrace_attributes_type" />
+		</xs:choice>
+	</xs:complexType>
+
+	<!-- Maps to lttng_event struct -->
+	<xs:complexType name="event_type">
+		<xs:all>
+			<xs:element name="type" type="event_type_type" default="TRACEPOINT" minOccurs="0" />
+			<xs:element name="name" type="name_type" minOccurs="0" />
+			<xs:element name="loglevel_type" type="loglevel_type" default="ALL" minOccurs="0" />
+			<xs:element name="loglevel" type="loglevel_string_type" default="" minOccurs="0" />
+			<xs:element name="enabled" type="enable_string_type" default=" [disabled]" minOccurs="0" />
+			<xs:element name="filter" type="filter_string_type" minOccurs="0" />
+			<xs:element name="exclusion" type="exclusion_string_type" minOccurs="0" />
+			<xs:element name="attributes" type="event_attributes_type" minOccurs="0" />
+			<xs:element name="event_fields" type="event_fields_type" minOccurs="0" />
+		</xs:all>
+	</xs:complexType>
+
+	<!-- Maps to mi_lttng_version struct -->
+	<xs:complexType name="version_type">
+		<xs:all>
+			<xs:element name="name" type="name_type" />
+			<xs:element name="string" type="name_type" />
+			<xs:element name="major" type="uint32_type" />
+			<xs:element name="url" type="xs:string" />
+			<xs:element name="minor" type="uint32_type" />
+			<xs:element name="license" type="xs:string" />
+			<xs:element name="patchLevel" type="uint32_type" />
+			<xs:element name="description" type="xs:string" />
+		</xs:all>
+	</xs:complexType>
+
+	<xs:complexType name="event_list_type">
+		<xs:sequence>
+			<xs:element name="event" type="event_type" minOccurs="0" maxOccurs="unbounded" />
+		</xs:sequence>
+	</xs:complexType>
+
+	<!-- Maps to the lttng_domain_type enum -->
+	<xs:simpleType name="domain_type_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="KERNEL"/>
+			<xs:enumeration value="UST"/>
+			<xs:enumeration value="JUL"/>
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the lttng_buffer_type enum -->
+	<xs:simpleType name="domain_buffer_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="PER_PID"/>
+			<xs:enumeration value="PER_UID"/>
+			<xs:enumeration value="GLOBAL"/>
+		</xs:restriction>
+	</xs:simpleType>
+
+	<xs:simpleType name="channel_overwrite_mode_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="DISCARD" />
+			<xs:enumeration value="OVERWRITE" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<!-- Maps to the lttng_event_output enum -->
+	<xs:simpleType name="event_output_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="SPLICE" />
+			<xs:enumeration value="MMAP" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<xs:complexType name="pid_type">
+		<xs:all>
+			<xs:element name="id" type="xs:int"/>
+			<xs:element name="name" type="name_type"/>
+			<xs:element name="events" type="event_list_type" minOccurs="0" />
+		</xs:all>
+	</xs:complexType>
+
+	<xs:complexType name="pids_type">
+		<xs:sequence>
+			<xs:element name="pid" type="pid_type" minOccurs="0" maxOccurs="unbounded" />
+		</xs:sequence>
+	</xs:complexType>
+
+	<!-- Maps to struct lttng_domain and contains channels -->
+	<xs:complexType name="domain_type">
+		<xs:all>
+			<xs:element name="type" type="domain_type_type"/>
+			<xs:element name="buffer_type" type="domain_buffer_type"/>
+			<xs:element name="pids" type="pids_type" minOccurs="0" />
+			<xs:element name="channels" type="channels_type" minOccurs="0" />
+			<xs:element name="events" type="event_list_type" minOccurs="0" />
+		</xs:all>
+	</xs:complexType>
+
+	<!-- Maps to struct lttng_channel -->
+	<xs:complexType name="channel_type">
+		<xs:all>
+			<xs:element name="name" type="name_type"/>
+			<xs:element name="enabled" type="xs:boolean" default="true" minOccurs="0"/>
+			<xs:element name="attributes" type="channel_attributes_type" minOccurs="0"/>
+			<xs:element name="events" type="event_list_type"/>
+		</xs:all>
+	</xs:complexType>
+
+	<!-- Maps to struct lttng_channel_attr -->
+	<xs:complexType name="channel_attributes_type">
+		<xs:all>
+			<xs:element name="overwrite_mode" type="channel_overwrite_mode_type" default="DISCARD" minOccurs="0"/>
+			<xs:element name="subbuffer_size" type="uint64_type" minOccurs="0"/> <!-- bytes -->
+			<xs:element name="subbuffer_count" type="uint64_type" default="4" minOccurs="0"/>
+			<xs:element name="switch_timer_interval" type="uint32_type" default="0" minOccurs="0"/>  <!-- usec -->
+			<xs:element name="read_timer_interval" type="uint32_type"/>  <!-- usec -->
+			<xs:element name="output_type" type="event_output_type"/>
+			<xs:element name="tracefile_size" type="uint64_type" default="0" minOccurs="0"/> <!-- bytes -->
+			<xs:element name="tracefile_count" type="uint64_type" default="0" minOccurs="0"/>
+			<xs:element name="live_timer_interval" type="uint32_type" default="0" minOccurs="0"/> <!-- usec -->
+		</xs:all>
+	</xs:complexType>
+
+	<xs:complexType name="channels_type">
+		<xs:sequence>
+			<xs:element name="channel" type="channel_type" minOccurs="0" maxOccurs="unbounded" />
+		</xs:sequence>
+	</xs:complexType>
+
+	<xs:complexType name="session_type">
+		<xs:all>
+			<xs:element name="name" type="name_type" />
+			<xs:element name="path" type="name_type" />
+			<xs:element name="enabled" type="xs:boolean" default="false" />
+			<xs:element name="snapshot_mode" type="uint32_type" />
+			<xs:element name="live_timer_interval" type="uint32_type" />
+			<xs:element name="channels" type="channels_type" minOccurs="0" />
+			<xs:element name="domains" type="domains_type" minOccurs="0" />
+		</xs:all>
+	</xs:complexType>
+
+	<xs:complexType name="event_field_type">
+		<xs:all>
+			<xs:element name="name" type="name_type" />
+			<xs:element name="type" type="event_field_type_type"/>
+			<xs:element name="nowrite" type="xs:int"/>
+		</xs:all>
+	</xs:complexType>
+
+
+	<xs:complexType name="domains_type">
+		<xs:sequence>
+			<xs:element name="domain" type="domain_type" minOccurs="0" maxOccurs="unbounded" />
+		</xs:sequence>
+	</xs:complexType>
+
+	<xs:complexType name="sessions_type">
+		<xs:sequence>
+			<xs:element name="session" type="session_type" minOccurs="0" maxOccurs="unbounded" />
+		</xs:sequence>
+	</xs:complexType>
+
+	<xs:complexType name="event_fields_type">
+		<xs:sequence>
+			<xs:element name="event_field" type="event_field_type" minOccurs="0" maxOccurs="unbounded" />
+		</xs:sequence>
+	</xs:complexType>
+
+	<xs:complexType name="output_type">
+		<xs:choice>
+			<xs:element name="domains" type="domains_type" minOccurs="0" />
+			<xs:element name="sessions" type="sessions_type" minOccurs="0" />
+			<xs:element name="version" type="version_type" minOccurs="0" />
+		</xs:choice>
+	</xs:complexType>
+
+	<!-- Maps to the mi_lttng commands -->
+	<xs:simpleType name="command_string_type">
+		<xs:restriction base="xs:string">
+			<xs:enumeration value="list" />
+			<xs:enumeration value="version" />
+		</xs:restriction>
+	</xs:simpleType>
+
+	<xs:element name="command">
+		<xs:complexType>
+			<xs:all>
+				<xs:element name="name" type="command_string_type" maxOccurs="1" />
+				<xs:element name="output" type="output_type" maxOccurs="1" />
+			</xs:all>
+		</xs:complexType>
+	</xs:element>
+</xs:schema>
-- 
1.8.3.2
