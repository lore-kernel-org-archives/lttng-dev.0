From: David OShea <David.OShea@quantum.com>
Subject: Patches to enable building on CentOS 5.x (glibc 2.5)
Date: Wed, 15 May 2013 11:38:10 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB23FDCE2B__2156.77353921837$1368617940$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=3847b232ea=david.oshea@quantum.com>)
	id 1Uca2C-0004Jy-Ln
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 07:38:16 -0400
Received: from pps.filterd (m0001151 [127.0.0.1])
	by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	r4FBXrRO021461
	for <lttng-dev@lists.lttng.org>; Wed, 15 May 2013 04:38:15 -0700
Received: from ppoxedge1.quantum.com ([146.174.252.27])
	by mx0b-000ceb01.pphosted.com with ESMTP id 1cbkfesmth-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Wed, 15 May 2013 04:38:15 -0700
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

Hi,

Would contributions of patches to enable lttng-tools and lttng-ust to build with glibc 2.5 (as is shipped with CentOS 5.x) and to enable lttng-gen-tp to run with Python 2.4 (as shipped on CentOS 5.x) be accepted?

What is missing from glibc 2.5 is:

- a system call wrapper for sched_getcpu()
- a system call wrapper for sync_file_range()
- htobe32() and other similar endian conversion functions

babeltrace and userspace-rcu did not require patching.

Thanks in advance,
David

P.S. If you see this, thanks for all your recent replies, Mathieu, I will try to get back to you soon!

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
