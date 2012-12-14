From: David OShea <David.OShea@quantum.com>
Subject: Poor handling of spaces in field names
Date: Fri, 14 Dec 2012 00:05:12 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F8A09C__36586.1357808628$1355443563$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=8695654041=david.oshea@quantum.com>)
	id 1TjImD-00013N-Ak
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 19:05:17 -0500
Received: from pps.filterd (m0030277 [127.0.0.1])
	by mx0a-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	qBE04hSO019118
	for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2012 16:05:16 -0800
Received: from ppoxedge2.quantum.com ([146.174.252.28])
	by mx0a-000ceb01.pphosted.com with ESMTP id 197rs7g1te-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2012 16:05:16 -0800
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

I never expected to be able to put spaces in field names, but I accidentally did so and had quite a bit of trouble debugging the problem, as 'babeltrace -v <path>' just gave me:

"""
error syntax error
[error] Error creating AST
[warning] Unable to open trace metadata for path "[...]".
[warning] [Context] Cannot open_trace of the format [...] .

[warning] [Context] cannot open trace "[...]" from [...] for reading.
"""

I had to set BABELTRACE_DEBUG=1 to see the metadata scanner and parser debug output to figure out what I'd done wrong :)

Would it be possible and practical to have the macros generate some dummy code using the field names in order to detect them not being valid identifiers at compile time?  Better error messages from the metadata parser would also be nice, but I imagine that's probably not so easy.

Thanks in advance,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
