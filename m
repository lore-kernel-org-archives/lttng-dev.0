From: David OShea <David.OShea@quantum.com>
Subject: Arrays printed in hex
Date: Thu, 10 Jan 2013 04:49:48 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F8AEE2__15520.9049735733$1357793439$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=9722cc9147=david.oshea@quantum.com>)
	id 1TtA5R-0008Nv-Qb
	for lttng-dev@lists.lttng.org; Wed, 09 Jan 2013 23:49:53 -0500
Received: from pps.filterd (m0001151 [127.0.0.1])
	by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	r0A4natE029131
	for <lttng-dev@lists.lttng.org>; Wed, 9 Jan 2013 20:49:52 -0800
Received: from ppoxedge1.quantum.com ([146.174.252.27])
	by mx0b-000ceb01.pphosted.com with ESMTP id 19rhgtbdgm-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Wed, 09 Jan 2013 20:49:52 -0800
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

In lttng-ust 2.0.5, tracepoint.h's comments include:

"""
 *         * Integer, printed in base 10 * 
 *         ctf_integer(int, field_a, arg0)
 *
 *         * Integer, printed with 0x base 16 * 
 *         ctf_integer_hex(unsigned long, field_d, arg1)
[...]
 *         * Array sequence of signed integer values * 
 *         ctf_array(long, field_f, arg4, FIXED_LEN4)
 *         ctf_sequence(long, field_g, arg4, size_t, arg4_len)
"""

Could _hex versions of ctf_array() and ctf_sequence() be easily added, where all the elements of the array/sequence would be output in hex by babeltrace?

Thanks in advance,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
