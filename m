From: David Bryant <david.bryant@quantum.com>
Subject: tracepoint provider: static versus dynamic linking
	(TRACEPOINT_PROBE_DYNAMIC_LINKAGE)
Date: Thu, 8 Nov 2012 13:41:54 +1030
Message-ID: <509B22FA.2030800__34335.5922647335$1352344362$gmane$org@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=76591ce31e=david.bryant@quantum.com>)
	id 1TWIXI-0007CV-MX
	for lttng-dev@lists.lttng.org; Wed, 07 Nov 2012 22:12:08 -0500
Received: from pps.filterd (m0001158 [127.0.0.1])
	by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	qA83C8Dv007670
	for <lttng-dev@lists.lttng.org>; Wed, 7 Nov 2012 19:12:08 -0800
Received: from ppoxedge2.quantum.com ([146.174.252.28])
	by mx0b-000ceb01.pphosted.com with ESMTP id 18fadj9w6c-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Wed, 07 Nov 2012 19:12:07 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

What are the pros and cons of static versus dynamic linking of the 
tracepoint provider? I can't find much information looking around.

Are their any licensing related issues? For example, is closed-source 
software not allowed to use static linking?

Is it just an optimisation - allowing the program to run without probes 
connected?

Thanks,
Dave


Notes from my digging of how it works:

Looking at the preprocessor output of sample.c without/with 
TRACEPOINT_PROBE_DYNAMIC_LINKAGE defined I see:

$ diff -u sample.i.static sample.i.dynamic
--- sample.i.static    2012-11-08 13:29:04.049059515 +1030
+++ sample.i.dynamic    2012-11-08 13:29:04.169062438 +1030
@@ -746,7 +746,7 @@
  struct tracepoint __tracepoint_sample_component___message 
__attribute__((section("__tracepoints"))) = {
      __tp_strtab_sample_component___message,
      0,
      ((void *)0),
-    &__tracepoint_provider_sample_component,
+    ((void *)0),
      "char *, text",
  };

(line breaks added by me).

So the "int * tracepoint::tracepoint_provider_ref" member is set to 
((void *)0) in struct tracepoint:

struct tracepoint {
  const char *name;
  int state;
  struct tracepoint_probe *probes;
  int *tracepoint_provider_ref;         /* XXX */
  const char *signature;
  char padding[16];
};

So the static version is not dependent on the symbol 
"__tracepoint_provider_sample_component". Running 
LD_PRELOAD=libprovider.so ./sample (somehow?) reinstates that symbol. 
(Can't quite see how that works).

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
