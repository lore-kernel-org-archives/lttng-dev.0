From: David OShea <David.OShea@quantum.com>
Subject: LTTng-UST memory requirements
Date: Wed, 27 Mar 2013 10:02:52 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB23FCE56C__40338.0919284702$1364378631$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=1798f9fb1d=david.oshea@quantum.com>)
	id 1UKnC5-0003Gm-Qr
	for lttng-dev@lists.lttng.org; Wed, 27 Mar 2013 06:02:57 -0400
Received: from pps.filterd (m0001151 [127.0.0.1])
	by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	r2RA25bU025043
	for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2013 03:02:57 -0700
Received: from ppoxedge1.quantum.com ([146.174.252.27])
	by mx0b-000ceb01.pphosted.com with ESMTP id 1bay3q2fjs-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2013 03:02:57 -0700
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

Are any details available of the memory requirements for LTTng?  I'm particularly interested in UST, and not only the case where tracing is being performed, but also when no session is started.  For example.:

- Session daemon memory requirements: I assume this would be a function of the number of tracepoints, trace providers, attached processes, sessions, etc.

- Consumer daemon memory requirements: how many of these would there be, how much memory does each use

- In-application memory requirements: I assume this would also be a function of the number of trace providers, trace points, etc.

Thanks in advance,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
