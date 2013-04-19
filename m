From: Jan Glauber <jan.glauber@gmail.com>
Subject: [RFC PATCH 2/2] babeltrace legacy LTT 2.6 -> CTF 1.8
	converter
Date: Fri, 19 Apr 2013 12:20:30 +0200
Message-ID: <1845d3d1367a0442a40ddb9e373ead879543eba4.1366364119.git.jan.glauber__3699.26173375479$1366366906$gmane$org@gmail.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1UT8RX-000523-13
	for lttng-dev@lists.lttng.org; Fri, 19 Apr 2013 06:21:23 -0400
Received: by mail-ea0-f179.google.com with SMTP id h14so914032eaj.10
	for <lttng-dev@lists.lttng.org>; Fri, 19 Apr 2013 03:21:17 -0700 (PDT)
In-Reply-To: <cover.1366364119.git.jan.glauber@gmail.com>
In-Reply-To: <cover.1366364119.git.jan.glauber@gmail.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add a standalone converter that can read LTT 2.6 trace format
and convert it to CTF 1.8.

- complete conversion of LTT metadata to a custom CTF
  which is readable by babeltrace / Eclipse
- exploit CTF streams to avoid conversion of old format event IDs
- converting a 32 bit trace on a 64 bit host is possible
- conversion of event file headers but direct copy of event data
  so conversion is reasonable fast
- maintains CPU information by creating CTF headers for event data
- conversion of UST trace data

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 converter/babeltrace-legacy.c | 1184 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1184 insertions(+)
 create mode 100644 converter/babeltrace-legacy.c

diff --git a/converter/babeltrace-legacy.c b/converter/babeltrace-legacy.c
new file mode 100644
index 0000000..e542a37
--- /dev/null
+++ b/converter/babeltrace-legacy.c
@@ -0,0 +1,1184 @@
+/*
+ * babeltrace-legacy.c
+ *
+ * BabelTrace - Convert legacy LTT 2.6 to CTF
+ *
+ * Copyright 2013 Harman Becker Automotive Systems GmbH
+ * Author: Jan Glauber <jan.glauber@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Requires the parse_format function from LTT.
+ */
+
+#define _GNU_SOURCE
+#include <config.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <dirent.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <strings.h>
+#include <inttypes.h>
+#include <search.h>
+
+#include <babeltrace/babeltrace-internal.h>
+#include <babeltrace/ctf/types.h>
+#include <babeltrace/uuid.h>
+#include "babeltrace/ltt-type-parser.h"
+
+#define LTT_MAGIC_NUMBER_LE 0x00D6B7ED
+#define LTT_MAGIC_NUMBER_BE 0xEDB7D600
+
+#define TSC_SHIFT		27
+#define TSC_MASK		((1UL << TSC_SHIFT) - 1)
+#define CTF_PACKET_SIZE		PAGE_SIZE
+#define CTF_PACKET_MASK		(CTF_PACKET_SIZE - 1)
+#define CTF_METADATA_MAGIC	0x75d11d57;
+#define CTF_TRACEDATA_MAGIC	0xc1fc1fc1;
+#define MAX_NR_STREAMS		1000
+#define MAX_CHANNEL_NAME	50
+
+/*
+ * The default is to assume the trace data is from a 32 bit system. This works
+ * regardless if the host is 32 bit or 64 bit. You need to remove the define
+ * only if _both_ host and target are 64 bit. Note that the conversion of
+ * 64 bit target to 32 bit host is not supported.
+ */
+#define CONVERT_FROM_32BIT
+
+char current_channel[MAX_CHANNEL_NAME];
+
+int babeltrace_debug, babeltrace_verbose;
+static char *s_inputname;
+static char *s_outputname;
+static int s_help;
+static unsigned char s_uuid[BABELTRACE_UUID_LEN];
+
+void *map;		/* mapped file object, only one is accessed at once */
+size_t map_len;		/* needed for munmap */
+int nr_events;
+int nr_streams;
+size_t written;
+int ltt_size_int, ltt_size_long, ltt_size_ptr, ltt_size_size_t;
+
+char zero_page[4096];
+
+/*
+ * If compiling under -m64 the struct must be packed, otherwise gcc pads up to
+ * the next 8 byte boundary and the struct ends on a 4 byte boundary...
+ */
+struct ltt_subbuffer_header {
+	uint64_t cycle_count_begin;	/* Cycle count at subbuffer start */
+	uint64_t cycle_count_end;	/* Cycle count at subbuffer end */
+	uint32_t magic_number;		/*
+					 * Trace magic number.
+					 * contains endianness information.
+					 */
+	uint8_t major_version;
+	uint8_t minor_version;
+	uint8_t arch_size;		/* Architecture pointer size */
+	uint8_t alignment;		/* LTT data alignment */
+	uint64_t start_time_sec;	/* NTP-corrected start time */
+	uint64_t start_time_usec;
+	uint64_t start_freq;		/*
+					 * Frequency at trace start,
+					 * used all along the trace.
+					 */
+	uint32_t freq_scale;		/* Frequency scaling (divisor) */
+	uint32_t data_size;		/* Size of data in subbuffer */
+	uint32_t sb_size;		/* Subbuffer size (including padding) */
+	uint32_t events_lost;		/*
+					 * Events lost in this subbuffer since
+					 * the beginning of the trace.
+					 * (may overflow)
+					 */
+	uint32_t subbuf_corrupt;	/*
+					 * Corrupted (lost) subbuffers since
+					 * the begginig of the trace.
+					 * (may overflow)
+					 */
+	uint8_t header_end[0];		/* End of header */
+}  __attribute__ ((packed));
+
+struct ltt_subbuffer_header ltt_hdr;
+
+/* the large ltt event header */
+struct ltt_event_header {
+	uint32_t packed;	/* 5 bit id, 27 bit tsc */
+	uint16_t event_id;
+	uint16_t event_size;
+	uint32_t packet_size;
+	uint64_t timestamp;
+}  __attribute__ ((aligned(4), packed));
+
+struct ltt_event_info {
+	char *channel_name;
+	char *event_name;
+	uint16_t event_id;
+	uint8_t size_int;
+	uint8_t size_long;
+	uint8_t size_ptr;
+	uint8_t size_size_t;
+	uint8_t align;
+	char *format;
+}  __attribute__ ((packed));
+
+struct lttng_metadata_header {
+	uint32_t magic;
+	uint8_t  uuid[16];
+	uint32_t checksum;
+	uint32_t content_size;
+	uint32_t packet_size;
+	uint8_t  compr_scheme;
+	uint8_t  enc_scheme;
+	uint8_t  checksum_scheme;
+	uint8_t  major;
+	uint8_t  minor;
+}  __attribute__ ((packed));
+
+struct lttng_packet_header {
+	uint32_t magic;
+	uint8_t  uuid[16];
+	uint32_t stream_id;
+} __attribute__ ((packed));
+
+struct lttng_packet_context {
+	uint64_t timestamp_begin;
+	uint64_t timestamp_end;
+	uint64_t content_size;
+	uint64_t packet_size;
+#ifdef CONVERT_FROM_32BIT /* 32 bit trace is converted */
+	uint32_t events_discarded;
+#else
+	unsigned long events_discarded;
+#endif
+	uint32_t cpu_id;
+};
+
+struct lttng_tracedata_header {
+	struct lttng_packet_header ph;
+	struct lttng_packet_context pc;
+};
+
+/* Metadata format string */
+static const char metadata_fmt[] =
+"/* CTF 1.8 */\n"
+"typealias integer { size = 8; align = 8; signed = false; } := uint8_t;\n"
+"typealias integer { size = 16; align = 8; signed = false; } := uint16_t;\n"
+"typealias integer { size = 32; align = 8; signed = false; } := uint32_t;\n"
+"typealias integer { size = 64; align = 8; signed = false; } := uint64_t;\n"
+"typealias integer { size = 64; align = 8; signed = false; } := unsigned long;\n"
+"typealias integer { size = 5; align = 1; signed = false; } := uint5_t;\n"
+"typealias integer { size = 27; align = 1; signed = false; } := uint27_t;\n"
+"\n"
+"trace {\n"
+"	major = 1;\n"
+"	minor = 8;\n"
+"	uuid = \"%s\";\n"				/* UUID */
+"	byte_order = %s;\n"				/* be or le */
+"	packet.header := struct {\n"
+"		uint32_t magic;\n"
+"		uint8_t  uuid[16];\n"
+"		uint32_t stream_id;\n"
+"	};\n"
+"};\n"
+"\n"
+"env {\n"
+"	hostname = \"%s\";\n"
+"	domain = \"kernel\";\n"			/* default is kernel */
+"	sysname = \"Linux\";\n"
+"	kernel_release = \"%s\";\n"			/* uname -r */
+"	kernel_version = \"%s\";\n"			/* uname -v */
+"	tracer_name = \"ltt\";\n"
+"	tracer_major = %u;\n"
+"	tracer_minor = %u;\n"
+"	tracer_patchlevel = 0;\n"
+"};\n"
+"\n"
+"clock {\n"
+"	name = monotonic;\n"
+"	uuid = \"2f580cb3-5650-40e7-9dde-796e33b39143\";\n"
+"	description = \"Monotonic Clock\";\n"
+"	freq = %llu; /* Frequency, in Hz */\n"		/* frequency from ltt */
+"	/* clock value offset from Epoch is: offset * (1/freq) */\n"
+"	offset = %llu;\n"
+"};\n"
+"\n"
+"typealias integer {\n"
+"	size = 27; align = 1; signed = false;\n"
+"	map = clock.monotonic.value;\n"
+"} := uint27_clock_monotonic_t;\n"
+"\n"
+"typealias integer {\n"
+"	size = 32; align = 8; signed = false;\n"
+"	map = clock.monotonic.value;\n"
+"} := uint32_clock_monotonic_t;\n"
+"\n"
+"typealias integer {\n"
+"	size = 64; align = 8; signed = false;\n"
+"	map = clock.monotonic.value;\n"
+"} := uint64_clock_monotonic_t;\n"
+"\n"
+"struct packet_context {\n"
+"	uint64_clock_monotonic_t timestamp_begin;\n"
+"	uint64_clock_monotonic_t timestamp_end;\n"
+"	uint64_t content_size;\n"
+"	uint64_t packet_size;\n"
+#ifdef CONVERT_FROM_32BIT /* 32 bit trace is converted */
+"	uint32_t events_discarded;\n"
+#else
+"	unsigned long events_discarded;\n"
+#endif
+"	uint32_t cpu_id;\n"
+"};\n"
+"\n"
+"struct event_header_ltt {\n"
+"	uint27_clock_monotonic_t timestamp;\n"
+"	enum : uint5_t { id = 0 ...28, id_size_tsc = 29, id_size = 30, id_only = 31 } id;\n"
+"	variant <id> {\n"
+"		struct { } id;\n"
+"		struct {\n"
+"			uint16_t id;\n"
+"			enum : uint16_t { packet_size = 0 ... 65534, extended = 65535 } packet_size;\n"
+"			variant <packet_size> {\n"
+"				struct { } packet_size;\n"
+"				struct {\n"
+"					uint32_t packet_size;\n"
+"				} extended;\n"
+"			} vst;\n"
+"			uint64_clock_monotonic_t timestamp;\n"
+"		} id_size_tsc;\n"
+"		struct {\n"
+"			uint16_t id;\n"
+"			enum : uint16_t { packet_size = 0 ... 65534, extended = 65535 } packet_size;\n"
+"			variant <packet_size> {\n"
+"				struct { } packet_size;\n"
+"				struct {\n"
+"					uint32_t packet_size;\n"
+"				} extended;\n"
+"			} vs;\n"
+"		} id_size;\n"
+"		struct {\n"
+"			uint16_t id;\n"
+"		} id_only;\n"
+"	} v;\n"
+"}%s;\n"
+"\n";
+
+static int _write(int fd, const void *buf, size_t len)
+{
+	int ret;
+
+	ret = write(fd, buf, len);
+	if (ret < 0) {
+		perror("write");
+		exit(EXIT_FAILURE);
+	}
+	if (ret != len) {
+		fprintf(stderr, "incomplete write\n");
+		exit(EXIT_FAILURE);
+	}
+	return len;
+}
+
+static int _zero(int fd, size_t pad_len)
+{
+	int len, bytes = 0;
+
+	while (pad_len > 0) {
+		len = pad_len;
+		if (len > PAGE_SIZE)
+			len = PAGE_SIZE;
+		_write(fd, zero_page, len);
+		pad_len -= len;
+		bytes += len;
+	}
+	return bytes;
+}
+
+int write_event_format(char *p, char trace_size, char c_size,
+		       enum ltt_type c_type, char base, char *name)
+{
+	char *start = p;
+	int align = (trace_size > ltt_hdr.alignment) ? ltt_hdr.alignment : trace_size;
+	char *fix;
+
+	/*
+	 * Userspace header can contain alignmenent = 0. Work around since
+	 * alignment of 0 is not allowed by CTF
+	 */
+	if (!align)
+		align = 1;
+
+	/* userspace ltt can mess up the name by adding a ":", remove that */
+	fix = rindex(name, ':');
+	if (fix)
+		*fix = 0;
+
+	/*
+	 * Events may have additional description after the name like:
+	 * _rw(...). Don't know how to process this with CTF so remove
+	 * everything in brackets.
+	 */
+	fix = index(name, '(');
+	if (fix)
+		*fix = 0;
+
+	switch (c_type) {
+	case LTT_TYPE_STRING:
+		/* string _filename; */
+		p += sprintf(p, "                ");
+		p += sprintf(p, "string _%s;\n", name);
+		break;
+	case LTT_TYPE_SIGNED_INT:
+		/* integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; } _pid; */
+		p += sprintf(p, "                ");
+		p += sprintf(p, "integer { size = %d; ", trace_size * 8);
+		p += sprintf(p, "align = %d; ", align * 8);
+		p += sprintf(p, "signed = 1; encoding = none; ");
+		p += sprintf(p, "base = %d; } _%s;\n", base, name);
+		break;
+	case LTT_TYPE_UNSIGNED_INT:
+		/* integer { size = 64; align = 8; signed = 0; encoding = none; base = 16; } _start; */
+		p += sprintf(p, "                ");
+		p += sprintf(p, "integer { size = %d; ", trace_size * 8);
+		p += sprintf(p, "align = %d; ", align * 8);
+		p += sprintf(p, "signed = 0; encoding = none; ");
+		p += sprintf(p, "base = %d; } _%s;\n", base, name);
+		break;
+	default:
+		printf("BUG\n");
+	}
+	return p - start;
+}
+
+static int map_file(int fd)
+{
+	struct stat sbuf;
+	int ret;
+
+	ret = fstat(fd, &sbuf);
+	if (ret < 0) {
+		perror("fstat");
+		return ret;
+	}
+
+	map_len = sbuf.st_size;
+	map = mmap(NULL, map_len, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) {
+		perror("mmap");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void align_pos(int *pos, int align)
+{
+	if (!align)
+		return;
+	if (*pos & (align - 1))
+		*pos += align - (*pos & (align - 1));
+}
+
+static int read_trace_header(struct ltt_subbuffer_header *hdr, void *addr)
+{
+	memcpy(hdr, addr, sizeof(struct ltt_subbuffer_header));
+	printf_verbose("Start TSC: %llx  Stop TSC: %llx\n",
+		(unsigned long long) hdr->cycle_count_begin,
+		(unsigned long long) hdr->cycle_count_end);
+	printf_verbose("Start sec: %llx  Start usex: %llx\n",
+		(unsigned long long) hdr->start_time_sec,
+		(unsigned long long) hdr->start_time_usec);
+	printf_verbose("Start freq: %llx  Freq_scale: %lx\n",
+		(unsigned long long) hdr->start_freq,
+		(unsigned long) hdr->freq_scale);
+	return sizeof(struct ltt_subbuffer_header);
+}
+
+static int parse_var_event_header(struct ltt_event_header *eh, void *addr)
+{
+	int len = sizeof(uint32_t);
+
+	eh->packed = *(uint32_t *) addr;
+	addr += sizeof(eh->packed);
+	eh->timestamp = eh->packed & TSC_MASK;
+	eh->event_id = eh->packed >> TSC_SHIFT;
+
+	switch (eh->event_id) {
+	case 29:
+		eh->event_id = *(uint16_t *) addr;
+		addr += sizeof(eh->event_id);
+		len += sizeof(eh->event_id);
+		eh->event_size = *(uint16_t *) addr;
+		addr += sizeof(eh->event_size);
+		len += sizeof(eh->event_size);
+		if (eh->event_size == 0xffff) {
+			eh->packet_size = *(uint32_t *) addr;
+			addr += sizeof(eh->packet_size);
+			len += sizeof(eh->packet_size);
+		}
+		eh->timestamp = *(uint64_t *) addr;
+		addr += sizeof(eh->timestamp);
+		len += sizeof(eh->timestamp);
+		break;
+	case 30:
+		eh->event_id = *(uint16_t *) addr;
+		addr += sizeof(eh->event_id);
+		len += sizeof(eh->event_id);
+		eh->event_size = *(uint16_t *) addr;
+		addr += sizeof(eh->event_size);
+		len += sizeof(eh->event_size);
+		if (eh->event_size == 0xffff) {
+			eh->packet_size = *(uint32_t *) addr;
+			addr += sizeof(eh->packet_size);
+			len += sizeof(eh->packet_size);
+		}
+		break;
+	case 31:
+		eh->event_id = *(uint16_t *) addr;
+		addr += sizeof(eh->event_id);
+		len += sizeof(eh->event_id);
+		break;
+	}
+	return len;
+}
+
+static int read_event_header(struct ltt_event_header *eh, void *addr)
+{
+	memset(eh, 0, sizeof(*eh));
+	return parse_var_event_header(eh, addr);
+}
+
+static int is_empty_event_header(struct ltt_event_header *eh)
+{
+	struct ltt_event_header zero_eh;
+
+	memset(&zero_eh, 0, sizeof(zero_eh));
+	if (memcmp(eh, &zero_eh, sizeof(*eh)) == 0)
+		return 1;
+	else
+		return 0;
+}
+static int write_tracedata_header(int fd, uint32_t csize, uint32_t psize, int cpu)
+{
+	struct lttng_tracedata_header th;
+	ENTRY e, *eptr;
+
+	/* find stream id */
+	e.key = strdup(current_channel);
+	eptr = hsearch(e, FIND);
+	if (!eptr)
+		fprintf(stderr, "error: channel name not found\n");
+
+	memset(&th, 0, sizeof(th));
+	th.ph.magic = CTF_TRACEDATA_MAGIC;
+	memcpy(&th.ph.uuid, s_uuid, BABELTRACE_UUID_LEN);
+	th.ph.stream_id = (int) (unsigned long) eptr->data;
+
+	if (csize)					/* in bits... */
+		th.pc.content_size = csize * 8;
+	else
+		th.pc.content_size = CTF_PACKET_SIZE * 8;
+	if (psize)					/* in bits... */
+		th.pc.packet_size = psize * 8;
+	else
+		th.pc.packet_size = CTF_PACKET_SIZE * 8;
+
+	/* copy timestamps */
+	th.pc.timestamp_begin = ltt_hdr.cycle_count_begin;
+	th.pc.timestamp_end = ltt_hdr.cycle_count_end;
+
+	th.pc.events_discarded = ltt_hdr.events_lost;
+	th.pc.cpu_id = cpu;
+
+	return _write(fd, &th, sizeof(th));
+}
+
+static void print_event_header(struct ltt_event_header *eh)
+{
+	printf_verbose("Event header type: %d\n", eh->packed >> TSC_SHIFT);
+	printf_verbose("  timestamp short: %lx\n", eh->packed & TSC_MASK);
+	printf_verbose("  event id: %d\n", eh->event_id);
+	printf_verbose("  event size: %d\n", eh->event_size);
+	printf_verbose("  timestamp: %llx\n", (unsigned long long) eh->timestamp);
+	printf_verbose("\n");
+}
+
+static int copy_event_data(int fd, struct ltt_subbuffer_header *lh,
+			   void *addr, int cpu, int old_hdr_len)
+{
+	int new_hdr_len = sizeof(struct lttng_tracedata_header);
+	uint32_t psize, dsize, esize;
+	size_t pad_len;
+	off_t pos;
+
+	/* size must be adjusted to fit the new header size */
+	esize = lh->sb_size - old_hdr_len; /* includes padding, just copy it over to avoid manual padding */
+	dsize = lh->data_size - old_hdr_len + new_hdr_len;
+
+	psize = lh->sb_size - old_hdr_len + new_hdr_len;
+	printf_debug("new psize: %x\n", psize);
+	psize = (psize + CTF_PACKET_SIZE) & ~CTF_PACKET_MASK;
+	printf_debug("aligned psize: %x\n", psize);
+
+	printf_debug("trace_header:  packet_size: %x  data_size: %x  event size: %x\n", psize, dsize, esize);
+	write_tracedata_header(fd, dsize, psize, cpu);
+
+	/* copy event data from the input file */
+	_write(fd, addr, esize);
+	addr += esize;
+	printf_debug("copied 0x%lx data bytes\n", (unsigned long) esize);
+
+	/* now look where we are and zero pad until packet_size */
+	pos = lseek(fd, 0, SEEK_CUR);
+	printf_debug("events copied up to 0x%lx\n", pos);
+
+	pad_len = CTF_PACKET_SIZE - (pos & CTF_PACKET_MASK);
+	printf_debug("starting next header at: 0x%lx  padding size: %zu\n", pos + pad_len, pad_len);
+	_zero(fd, pad_len);
+	return esize;
+}
+
+static int get_cpu_from_filename(const char *fname)
+{
+	char *start = rindex(fname, '_') + 1;
+
+	if (!start)
+		fprintf(stderr, "malformed file name: %s\n", fname);
+	return atoi(start);
+}
+
+static void set_current_channel_name(const char *fname)
+{
+	char *end = rindex(fname, '_');
+	int len;
+
+	if (!end)
+		fprintf(stderr, "malformed file name\n");
+	len = end - fname;
+
+	memset(current_channel, 0, MAX_CHANNEL_NAME);
+	strncpy(current_channel, fname, len);
+	printf_debug("set current name to: %s\n", current_channel);
+}
+
+static int parse_data_file(int in_dir_fd, char *src, char *dst, char *fname)
+{
+	int ret, in_fd, out_fd, cpu, events = 0;
+	struct ltt_event_header eh;
+	size_t pad_len;
+	void *addr;
+
+	/* skip special unrelated file */
+	if (strcmp("wrsv.filelist", fname) == 0)
+		return 0;
+
+	in_fd = openat(in_dir_fd, src, O_RDONLY);
+	if (in_fd < 0) {
+		perror("openat");
+		return -ENOENT;
+	}
+
+	ret = map_file(in_fd);
+	if (ret < 0)
+		goto out_map;
+
+	addr = map;
+	cpu = get_cpu_from_filename(fname);
+	set_current_channel_name(fname);
+
+	out_fd = open(dst, O_RDWR|O_CREAT,
+		      S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
+	if (out_fd < 0) {
+		perror("open");
+		ret = out_fd;
+		goto out_open;
+	}
+
+	while (1) {
+		void *old_hdr_start = addr;
+
+		if (addr - map > map_len || addr + sizeof(ltt_hdr) - map > map_len)
+			break;
+
+		addr += read_trace_header(&ltt_hdr, addr);
+
+		read_event_header(&eh, addr);
+		if (is_empty_event_header(&eh))
+			break;
+		print_event_header(&eh);
+		events++;
+
+		addr += copy_event_data(out_fd, &ltt_hdr, addr, cpu, addr - old_hdr_start);
+	}
+
+	/* no events in the trace file -> get rid of it */
+	if (!events) {
+		close(out_fd);
+		unlink(dst);
+		printf("Skipping empty data file %s\n", src);
+		goto out_open;
+	} else
+		printf("Converting data file %s -> %s\n", src, dst);
+
+	/* the final header */
+	write_tracedata_header(out_fd, sizeof(struct lttng_tracedata_header), 0, cpu);
+	/* pad header page with zeros */
+	pad_len = CTF_PACKET_SIZE - sizeof(struct lttng_tracedata_header);
+	_zero(out_fd, pad_len);
+
+	close(out_fd);
+out_open:
+	ret = munmap(map, map_len);
+	if (ret)
+		perror("munmap");
+out_map:
+	close(in_fd);
+	return ret;
+}
+
+static void parse_data_files(int in_dir_fd, DIR *in_dir, DIR *out_dir)
+{
+	char in_path[PATH_MAX], out_path[PATH_MAX];
+	struct dirent *dentry;
+	struct stat sbuf;
+	int len, ret;
+
+	while ((dentry = readdir(in_dir)) != NULL) {
+		if (dentry->d_name[0] == '.')
+			continue;
+		len = strlen(dentry->d_name);
+		if (!len)
+			continue;
+		/* don't copy metadata files! */
+		if (len >= 8 && !strncmp(dentry->d_name, "metadata", 8))
+			continue;
+
+		strcpy(in_path, s_inputname);
+		strcpy(in_path + strlen(in_path), "/");
+		strcpy(in_path + strlen(in_path), dentry->d_name);
+		strcpy(out_path, s_outputname);
+		strcpy(out_path + strlen(out_path), "/");
+		strcpy(out_path + strlen(out_path), dentry->d_name);
+
+		ret = stat(in_path, &sbuf);
+		if (ret) {
+			perror("stat");
+			continue;
+		}
+
+		if (S_ISREG(sbuf.st_mode))
+			parse_data_file(in_dir_fd, in_path, out_path, dentry->d_name);
+	}
+}
+
+static void write_stream_metadata(DIR *in_dir, int fd)
+{
+	int len, dist, ret, i, streams, cpus = 0, files = 0;
+	struct dirent *dentry;
+	struct stat sbuf;
+	char fname[PATH_MAX];
+	char buf[8 * PAGE_SIZE];
+	char *p = buf;
+	char *pos;
+
+	/*
+	 * We need to declare the streams _before_ we parse the events from
+	 * all files. nr_streams is still zero so we need another way to detect
+	 * the number of streams...
+	 */
+	memset(fname, 0, sizeof(fname));
+	sprintf(fname, "%s/metadata_0", s_inputname);
+	pos = rindex(fname, '_');
+
+	while (42) {
+		ret = stat(fname, &sbuf);
+		if (ret < 0)
+			break;
+		cpus++;
+		sprintf(pos + 1, "%d", cpus);
+	}
+
+	/* count the number of regular input files wo. special files */
+	while ((dentry = readdir(in_dir)) != NULL) {
+		memset(fname, 0, sizeof(fname));
+		if (dentry->d_name[0] == '.')
+			continue;
+
+		len = strlen(dentry->d_name);
+		if (strcmp(dentry->d_name, "wrsv.filelist") == 0)
+			continue;
+
+		strcpy(fname, s_inputname);
+		strcpy(fname + strlen(fname), "/");
+		strcpy(fname + strlen(fname), dentry->d_name);
+
+		ret = stat(fname, &sbuf);
+		if (ret) {
+			perror("stat");
+			continue;
+		}
+
+		if (S_ISREG(sbuf.st_mode))
+			files++;
+	}
+	/* reset dir stream position to beginning for subsequent use */
+	rewinddir(in_dir);
+
+	printf_debug("cpus: %d  files: %d\n", cpus, files);
+	streams = files / cpus;
+	for (i = 0; i < streams; i++) {
+		p += sprintf(p, "stream {\n");
+		p += sprintf(p, "	id = %u;\n", i);
+		p += sprintf(p, "	event.header := struct event_header_ltt;\n");
+		p += sprintf(p, "	packet.context := struct packet_context;\n");
+		p += sprintf(p, "};\n");
+		p += sprintf(p, "\n");
+	}
+
+	/* get len of event data */
+	len = p - buf;
+
+	/* now check if we cross the packet_size border */
+	dist = written % CTF_PACKET_SIZE;
+	dist = CTF_PACKET_SIZE - dist;
+	if (dist >= len) {
+		written += _write(fd, buf, len);
+		return;
+	}
+
+	/* not enough space until border */
+	written += _write(fd, buf, dist);
+
+	/* rest of event data */
+	written += _write(fd, buf + dist, len - dist);
+}
+
+static void write_event_metadata(struct ltt_event_info *ec, int fd)
+{
+	char buf[PAGE_SIZE];	/* should be enough for any event */
+	char *p = buf;
+	ENTRY e, *eptr;
+	int len, dist;
+
+	/* find stream id */
+	e.key = strdup(ec->channel_name);
+	eptr = hsearch(e, FIND);
+	if (!eptr)
+		fprintf(stderr, "error: channel name not found\n");
+
+	p += sprintf(p, "event {\n");
+	p += sprintf(p, "	name = %s_%s;\n", ec->channel_name, ec->event_name);
+	p += sprintf(p, "	id = %u;\n", ec->event_id);
+	p += sprintf(p, "	stream_id = %u;\n", (int) (unsigned long) eptr->data);
+	p += sprintf(p, "	fields := struct {\n");
+
+	if (ec->format)
+		p += parse_format(p, ec->format, ltt_hdr.arch_size, ltt_size_long,
+				  ltt_size_size_t, write_event_format);
+	p += sprintf(p, "	};\n");
+	p += sprintf(p, "};\n");
+	p += sprintf(p, "\n");
+
+	/* get len of event data */
+	len = p - buf;
+
+	/* now check if we cross the packet_size border */
+	dist = written % CTF_PACKET_SIZE;
+	dist = CTF_PACKET_SIZE - dist;
+	if (dist >= len) {
+		written += _write(fd, buf, len);
+		return;
+	}
+
+	/* not enough space until border */
+	written += _write(fd, buf, dist);
+
+	/* rest of event data */
+	written += _write(fd, buf + dist, len - dist);
+}
+
+static void *parse_events(void *addr, int out_fd)
+{
+	int len, pos = 0;
+	struct ltt_event_header eh;
+	struct ltt_event_info *ec;
+	ENTRY e, *eptr;
+
+	printf_debug("reading ehdr from: %p\n", addr);
+	pos += read_event_header(&eh, addr);
+
+	if (is_empty_event_header(&eh))
+		return NULL;
+	print_event_header(&eh);
+
+	ec = malloc(sizeof(*ec));
+	if (!ec) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(ec, 0, sizeof(*ec));
+
+	/* channel name string */
+	len = strlen(addr + pos);
+	if (!len)
+		return NULL;
+
+	ec->channel_name = malloc(len + 1);
+	memset(ec->channel_name, 0, len + 1);
+	strcpy(ec->channel_name, addr + pos);
+	pos += len + 1;
+
+	/* try to add to stream hash */
+	e.key = strdup(ec->channel_name);
+
+	eptr = hsearch(e, FIND);
+	if (!eptr) {
+		/* not yet cached, add it */
+		e.data = (void *) (unsigned long) (nr_streams++);
+		eptr = hsearch(e, ENTER);
+		if (!eptr)
+			fprintf(stderr, "hash table full\n");
+		printf_debug("hashing channel: %s -> stream_id: %u\n",
+			eptr ? e.key : NULL, eptr ? (int) (unsigned long) (e.data) : 0);
+	} else {
+		/* nothing to do */
+		printf_debug("channel: %s already hashed to stream_id %u\n", e.key, (int) (unsigned long) eptr->data);
+		free(e.key);
+	}
+
+	/* event name string */
+	len = strlen(addr + pos);
+	if (!len)
+		return NULL;
+
+	ec->event_name = malloc(len + 1);
+	memset(ec->event_name, 0, len + 1);
+	strcpy(ec->event_name, addr + pos);
+	pos += len + 1;
+	printf_debug("event: %s\n", ec->event_name);
+	nr_events++;
+
+	/* event id */
+	if (ltt_hdr.alignment)
+		align_pos(&pos, sizeof(uint16_t));
+	ec->event_id = *(uint16_t *) (addr + pos);
+	printf_verbose("Event channel: %s  name: %s  id: %d\n",
+		ec->channel_name, ec->event_name, ec->event_id);
+	pos += 2;
+
+	/* size values */
+	ltt_size_int = *(uint8_t *) (addr + pos);
+	pos++;
+	ltt_size_long = *(uint8_t *) (addr + pos);
+	pos++;
+	ltt_size_ptr = *(uint8_t *) (addr + pos);
+	pos++;
+	ltt_size_size_t = *(uint8_t *) (addr + pos);
+	pos++;
+
+	/* get align value */
+	ec->align = *(uint8_t *) (addr + pos);
+	pos++;
+
+	align_pos(&pos, ec->align);
+
+	pos += parse_var_event_header(&eh, addr + pos);
+	print_event_header(&eh);
+
+	/* skip channel string repeated */
+	pos += strlen(ec->channel_name) + 1;
+
+	/* skip event string repeated */
+	pos += strlen(ec->event_name) + 1;
+
+	/* format string, empty strings are possible! */
+	len = strlen(addr + pos);
+
+	if (len) {
+		ec->format = malloc(len + 1);
+		memset(ec->format, 0, len + 1);
+		strcpy(ec->format, addr + pos);
+	}
+	printf_debug("format: %s\n", ec->format);
+	pos += len + 1;
+
+	align_pos(&pos, ec->align);
+
+	/* append event description to metadata */
+	write_event_metadata(ec, out_fd);
+
+	if (len)
+		free(ec->format);
+	free(ec->event_name);
+	free(ec->channel_name);
+	free(ec);
+	return addr + pos;
+}
+
+static int read_trace_header_fd(int in_dir_fd, char *name)
+{
+	int ret, fd;
+
+	fd = openat(in_dir_fd, name, O_RDONLY);
+	if (fd < 0) {
+		perror("openat");
+		return fd;
+	}
+
+	ret = map_file(fd);
+	if (ret < 0)
+		goto out;
+	memcpy(&ltt_hdr, map, sizeof(struct ltt_subbuffer_header));
+
+	ret = munmap(map, map_len);
+	if (ret)
+		perror("munmap");
+out:
+	close(fd);
+	return ret;
+}
+
+static int parse_input_metadata(int in_dir_fd, int out_fd)
+{
+	int ret, fd, nr = 0;
+	char name[12];
+	void *addr;
+
+next:
+	memset(name, 0, sizeof(name));
+	sprintf(name, "metadata_%d", nr);
+
+	fd = openat(in_dir_fd, name, O_RDONLY);
+	if (fd < 0)
+		/* only an error for metadata_0 which is checked before */
+		return -ENOENT;
+
+	ret = map_file(fd);
+	if (ret < 0) {
+		close(fd);
+		return 0;
+	}
+
+	addr = map;
+	addr += read_trace_header(&ltt_hdr, addr);
+
+	printf("Parsing metadata from file %s\n", name);
+	printf_verbose("Version %d:%d\n", ltt_hdr.major_version, ltt_hdr.minor_version);
+	printf_verbose("Start TSC: %llx  Stop  TSC: %llx\n",
+			(unsigned long long) ltt_hdr.cycle_count_begin,
+			(unsigned long long) ltt_hdr.cycle_count_end);
+
+	/* now fetch the events */
+	do {
+		addr = parse_events(addr, out_fd);
+	} while (addr);
+
+	ret = munmap(map, map_len);
+	if (ret)
+		perror("munmap");
+	ret = close(fd);
+	if (ret)
+		perror("close");
+	nr++;
+	goto next;
+}
+
+static void print_metadata(FILE *fp)
+{
+	char uuid_str[BABELTRACE_UUID_STR_LEN];
+	unsigned int major = 0, minor = 0;
+	int le, ret;
+
+	if (ltt_hdr.magic_number == LTT_MAGIC_NUMBER_LE)
+		le = 1;
+        else if (ltt_hdr.magic_number == LTT_MAGIC_NUMBER_BE)
+                le = 0;
+	else {
+		fprintf(stderr, "failed to parse ltt magic number\n");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = sscanf(VERSION, "%u.%u", &major, &minor);
+	if (ret != 2)
+		fprintf(stderr, "[warning] Incorrect babeltrace version format\n.");
+	babeltrace_uuid_unparse(s_uuid, uuid_str);
+	fprintf(fp, metadata_fmt,
+		uuid_str,
+		le ? "le" : "be",
+		"none",
+		"3.4",
+		"unknown",
+		ltt_hdr.major_version,
+		ltt_hdr.minor_version,
+		(unsigned long long) ltt_hdr.start_freq,
+		(unsigned long long) ltt_hdr.start_time_sec * 1000000000 + ltt_hdr.start_time_usec,
+		ltt_hdr.alignment ? " align(32)" : "");
+}
+
+static void usage(FILE *fp)
+{
+	fprintf(fp, "BabelTrace Legacy Converter %s\n", VERSION);
+	fprintf(fp, "\n");
+	fprintf(fp, "Convert from LTT 2.6 to CTF 1.8 format.\n");
+	fprintf(fp, "\n");
+	fprintf(fp, "usage : babeltrace-legacy [OPTIONS] INPUT OUTPUT\n");
+	fprintf(fp, "\n");
+	fprintf(fp, "  INPUT                          Input trace path\n");
+	fprintf(fp, "\n");
+	fprintf(fp, "  OUTPUT                         Output trace path\n");
+	fprintf(fp, "\n");
+	fprintf(fp, "  -d                             Debug mode\n");
+	fprintf(fp, "\n");
+	fprintf(fp, "  -v                             Verbose mode\n");
+	fprintf(fp, "\n");
+}
+
+static int parse_args(int argc, char **argv)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "-h")) {
+			s_help = 1;
+			return 0;
+		} else if (!strcmp(argv[i], "-d")) {
+			babeltrace_debug = 1;
+		} else if (!strcmp(argv[i], "-v")) {
+			babeltrace_verbose = 1;
+		} else if (argv[i][0] == '-') {
+			return -EINVAL;
+		} else if (!s_inputname) {
+			s_inputname = argv[i];
+		} else if (!s_outputname) {
+			s_outputname = argv[i];
+		}
+	}
+	if (!s_inputname || !s_outputname)
+		return -EINVAL;
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int out_metadata_fd, ret;
+	DIR *in_dir, *out_dir;
+	int in_dir_fd, out_dir_fd;
+	FILE *out_metadata_fp;
+	off_t pos;
+
+	ret = parse_args(argc, argv);
+	if (ret) {
+		fprintf(stderr, "Error: invalid argument.\n");
+		usage(stderr);
+		goto error;
+	}
+
+	if (s_help) {
+		usage(stdout);
+		exit(EXIT_SUCCESS);
+	}
+
+	babeltrace_uuid_generate(s_uuid);
+
+	hcreate(MAX_NR_STREAMS);
+
+	in_dir = opendir(s_inputname);
+	if (!in_dir) {
+		perror("opendir");
+		goto error;
+	}
+	in_dir_fd = dirfd(in_dir);
+	if (in_dir_fd < 0) {
+		perror("dirfd");
+		goto error_closedirin;
+	}
+
+	ret = mkdir(s_outputname, S_IRWXU|S_IRWXG);
+	if (ret) {
+		perror("mkdir");
+		goto error_mkdir;
+	}
+
+	out_dir = opendir(s_outputname);
+	if (!out_dir) {
+		perror("opendir");
+		goto error_rmdir;
+	}
+	out_dir_fd = dirfd(out_dir);
+	if (out_dir_fd < 0) {
+		perror("dirfd");
+		goto error_closedir;
+	}
+
+	out_metadata_fd = openat(out_dir_fd, "metadata", O_RDWR|O_CREAT,
+			     S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
+	if (out_metadata_fd < 0) {
+		perror("openat");
+		goto error_closedatastream;
+	}
+
+	out_metadata_fp = fdopen(out_metadata_fd, "aw");
+	if (!out_metadata_fp) {
+		perror("fdopen");
+		goto error_closemetadatafd;
+	}
+
+	read_trace_header_fd(in_dir_fd, "metadata_0");
+
+	print_metadata(out_metadata_fp);
+	fflush(out_metadata_fp);
+
+	lseek(out_metadata_fd, 0 , SEEK_SET);
+	pos = lseek(out_metadata_fd, 0, SEEK_END);	/* make sure writing to out_metadata_fd goes to the end */
+	if (pos < 0)
+		perror("lseek");
+	/* reset written to pos otherwise we miss the metadata_fmt fprint */
+	written = pos;
+
+	write_stream_metadata(in_dir, out_metadata_fd);
+	parse_input_metadata(in_dir_fd, out_metadata_fd);
+
+	/* data files */
+	parse_data_files(in_dir_fd, in_dir, out_dir);
+
+	printf("\nTotal events converted: %d\n", nr_events);
+	hdestroy();
+	exit(EXIT_SUCCESS);
+
+error_closemetadatafd:
+	close(out_metadata_fd);
+error_closedatastream:
+	close(out_dir_fd);
+error_closedir:
+	closedir(out_dir);
+error_rmdir:
+	ret = rmdir(s_outputname);
+	if (ret)
+		perror("rmdir");
+error_mkdir:
+	close(in_dir_fd);
+error_closedirin:
+	closedir(in_dir);
+error:
+	hdestroy();
+	exit(EXIT_FAILURE);
+}
-- 
1.7.9.5
