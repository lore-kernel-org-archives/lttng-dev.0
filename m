From: David OShea <David.OShea@quantum.com>
Subject: TRACEPOINT_PROVIDER mismatch check in
 ust-tracepoint-event.h needs -Wsystem-headers
Date: Mon, 19 Nov 2012 04:06:19 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F87106__29433.3593723879$1353298026$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=76704a1f2b=david.oshea@quantum.com>)
	id 1TaIcp-00081m-M4
	for lttng-dev@lists.lttng.org; Sun, 18 Nov 2012 23:06:23 -0500
Received: from pps.filterd (m0001151 [127.0.0.1])
	by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	qAJ41rUv016934
	for <lttng-dev@lists.lttng.org>; Sun, 18 Nov 2012 20:06:22 -0800
Received: from ppoxedge1.quantum.com ([146.174.252.27])
	by mx0b-000ceb01.pphosted.com with ESMTP id 18p6vf1ymb-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Sun, 18 Nov 2012 20:06:22 -0800
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

I noticed that ust-tracepoint-event.h includes:

"""
/*
 * Stage 0 of tracepoint event generation.
 *
 * Check that each TRACEPOINT_EVENT provider argument match the
 * TRACEPOINT_PROVIDER by creating dummy callbacks.
 */
"""

If I ask GCC to output the preprocessor's output, I can see that the checks are behaving as expected - creating calls to functions whose names include the TRACEPOINT_EVENTs' provider arguments, and defining a function whose name includes the TRACEPOINT_PROVIDER value.  However, because I have installed the LTTng header files - they are in /usr/include/lttng - GCC (I'm using version 4.3.3) does not actually output any warnings regarding the calls to undefined functions because they are made in a "system header file".  If I pass -Wsystem-headers to GCC, then it does output warnings when I have a TRACEPOINT_PROVIDER mismatch, but I also get lots of warnings about unused parameters due to the way the tracepoint definitions work.

From some experimentation, it looks like enabling -Wsystem-headers, even if only for the trace provider .c file, would probably result in us getting lots of spurious warnings due to various Linux system header files too, so we don't really want to enable that. 

I'm not sure if there is any way you could "fix" this so that -Wsystem-headers isn't required, but perhaps it would at least be worth documenting that this flag could be used - but perhaps not recommend it - to enable those checks to occur.

This was seen with lttng-ust-2.0.5 patched with commit 009745db "Cache the procname per-thread rather than per-process to take into account that prctl() can be used to set thread names." and commit e699eda "don't spawn per-user thread if HOME is not set".

Thanks,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
