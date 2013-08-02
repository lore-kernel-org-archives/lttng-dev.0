From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace 1/3] Add sequence test
Date: Sat,  3 Aug 2013 05:42:32 +0800
Message-ID: <1375479754-22999-1-git-send-email-xiaonahappy13__16780.1130134196$1375451102$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V5FdA-0008Pk-Ky
	for lttng-dev@lists.lttng.org; Fri, 02 Aug 2013 09:43:02 -0400
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

Current tests do not cover sequence type in the babeltrace tests. This patch
adds an test that includes the sequence type.

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 tests/ctf-traces/succeed/sequence/channel0_0 |  Bin 0 -> 4096 bytes
 tests/ctf-traces/succeed/sequence/channel0_1 |  Bin 0 -> 4096 bytes
 tests/ctf-traces/succeed/sequence/channel0_2 |  Bin 0 -> 4096 bytes
 tests/ctf-traces/succeed/sequence/channel0_3 |  Bin 0 -> 4096 bytes
 tests/ctf-traces/succeed/sequence/metadata   |  106 ++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 tests/ctf-traces/succeed/sequence/channel0_0
 create mode 100644 tests/ctf-traces/succeed/sequence/channel0_1
 create mode 100644 tests/ctf-traces/succeed/sequence/channel0_2
 create mode 100644 tests/ctf-traces/succeed/sequence/channel0_3
 create mode 100644 tests/ctf-traces/succeed/sequence/metadata

diff --git a/tests/ctf-traces/succeed/sequence/channel0_0 b/tests/ctf-traces/succeed/sequence/channel0_0
new file mode 100644
index 0000000000000000000000000000000000000000..5038a2275f2c21864f12d52ab54a41da5a784f3b
GIT binary patch
literal 4096
zcmX>o|L0&NtFrNv34S-%S8WS&uHQ9_0SMaVMa4}O7#L#sCkKOQ1tyRv5Hx_vQDQU%
oMnhmU1V%$(Gz3ONU^E0qLtr!nMnhmU1V%$(Gz3ONU<ic(0A=$HqW}N^

literal 0
HcmV?d00001

diff --git a/tests/ctf-traces/succeed/sequence/channel0_1 b/tests/ctf-traces/succeed/sequence/channel0_1
new file mode 100644
index 0000000000000000000000000000000000000000..fd947382cfe4b983424cfc1cc43fa3f1b3cc364e
GIT binary patch
literal 4096
zcmX>o|L0&NtFrNv34S-%S8WS&uHQ9_0SM-H$cURNFfiCMP7Vgq3QQnTAZP%SaDoxe
t8fA=zz-S1JhQMeDjE2By2#kinXb6mkz-S1JhQMeDjE2By2n^N`0091_4gCNB

literal 0
HcmV?d00001

diff --git a/tests/ctf-traces/succeed/sequence/channel0_2 b/tests/ctf-traces/succeed/sequence/channel0_2
new file mode 100644
index 0000000000000000000000000000000000000000..9d848fcbc6f1df66cfb98b1b03006c572ac88249
GIT binary patch
literal 4096
zcmX>o|L0&NtFrNv34S-%S8WS&uHQ9_0SLH1DvO&cFfh1^P7Vgq8uB1fAZP%SaDoZQ
z0!x)%%9H>pWP?im2ZDb<{1=G-0P$}i{sqJ^c`m3r5hyJOr8S_m5tO!p(g|sCyfD2$
zW2kEOflJjiGdtnf44Rqkuwg6h%-(m2W@a;7`#>|Z6}0*IXq8SLsA|*9>;<wOG&38T
jg+{5-5Eu=C(GVC7fzc2c4S~@R7!85Z5Eu=CksSg6XVnzG

literal 0
HcmV?d00001

diff --git a/tests/ctf-traces/succeed/sequence/channel0_3 b/tests/ctf-traces/succeed/sequence/channel0_3
new file mode 100644
index 0000000000000000000000000000000000000000..ef385c38a03f8d341d866016156087807e99e6c7
GIT binary patch
literal 4096
zcmX>o|L0&NtFrNv34S-%S8WS&uHQ9_0SLa;Xp5UFFfdG!o*WFK6_`MxK+pgt;RG|B
tHOd$bfzc2c4S~@R7!85Z5Eu=C(GVC7fzc2c4S~@R7!85Z5E!f>007tg4$J@m

literal 0
HcmV?d00001

diff --git a/tests/ctf-traces/succeed/sequence/metadata b/tests/ctf-traces/succeed/sequence/metadata
new file mode 100644
index 0000000..2163abf
--- /dev/null
+++ b/tests/ctf-traces/succeed/sequence/metadata
@@ -0,0 +1,106 @@
+/* CTF 1.8 */
+typealias integer { size = 8; align = 8; signed = false; } := uint8_t;
+typealias integer { size = 16; align = 8; signed = false; } := uint16_t;
+typealias integer { size = 32; align = 8; signed = false; } := uint32_t;
+typealias integer { size = 64; align = 8; signed = false; } := uint64_t;
+typealias integer { size = 64; align = 8; signed = false; } := unsigned long;
+typealias integer { size = 5; align = 1; signed = false; } := uint5_t;
+typealias integer { size = 27; align = 1; signed = false; } := uint27_t;
+
+trace {
+	major = 1;
+	minor = 8;
+	uuid = "59052333-e490-4ed9-af7a-b652437fba9a";
+	byte_order = le;
+	packet.header := struct {
+		uint32_t magic;
+		uint8_t  uuid[16];
+		uint32_t stream_id;
+	};
+};
+
+env {
+	hostname = "host";
+	domain = "ust";
+	tracer_name = "lttng-ust";
+	tracer_major = 2;
+	tracer_minor = 3;
+};
+
+clock {
+	name = monotonic;
+	uuid = "5f3ed925-9d73-4637-b8e4-02077abc8c8f";
+	description = "Monotonic Clock";
+	freq = 1000000000; /* Frequency, in Hz */
+	/* clock value offset from Epoch is: offset * (1/freq) */
+	offset = 1375437179542680815;
+};
+
+typealias integer {
+	size = 27; align = 1; signed = false;
+	map = clock.monotonic.value;
+} := uint27_clock_monotonic_t;
+
+typealias integer {
+	size = 32; align = 8; signed = false;
+	map = clock.monotonic.value;
+} := uint32_clock_monotonic_t;
+
+typealias integer {
+	size = 64; align = 8; signed = false;
+	map = clock.monotonic.value;
+} := uint64_clock_monotonic_t;
+
+struct packet_context {
+	uint64_clock_monotonic_t timestamp_begin;
+	uint64_clock_monotonic_t timestamp_end;
+	uint64_t content_size;
+	uint64_t packet_size;
+	unsigned long events_discarded;
+	uint32_t cpu_id;
+};
+
+struct event_header_compact {
+	enum : uint5_t { compact = 0 ... 30, extended = 31 } id;
+	variant <id> {
+		struct {
+			uint27_clock_monotonic_t timestamp;
+		} compact;
+		struct {
+			uint32_t id;
+			uint64_clock_monotonic_t timestamp;
+		} extended;
+	} v;
+} align(8);
+
+struct event_header_large {
+	enum : uint16_t { compact = 0 ... 65534, extended = 65535 } id;
+	variant <id> {
+		struct {
+			uint32_clock_monotonic_t timestamp;
+		} compact;
+		struct {
+			uint32_t id;
+			uint64_clock_monotonic_t timestamp;
+		} extended;
+	} v;
+} align(8);
+
+stream {
+	id = 0;
+	event.header := struct event_header_compact;
+	packet.context := struct packet_context;
+};
+
+event {
+	name = "sequence event";
+	id = 0;
+	stream_id = 0;
+	loglevel = 1;
+	fields := struct {
+		integer { size = 64; align = 8; signed = 0; encoding = none; base = 10; } __seq_int_field_length;
+		integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; } _seq_int_field[ __seq_int_field_length ];
+		integer { size = 64; align = 8; signed = 0; encoding = none; base = 10; } __seq_long_field_length;
+		integer { size = 64; align = 8; signed = 1; encoding = none; base = 10; } _seq_long_field[ __seq_long_field_length ];
+	};
+};
-- 
1.7.1
