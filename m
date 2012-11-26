From: David OShea <David.OShea@quantum.com>
Subject: Re: libust "Error: Error opening shm" every ~4
	seconds	if HOME variable is not set
Date: Mon, 26 Nov 2012 09:13:01 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F87B70__18788.6130101562$1353921224$gmane$org@ZURMSG1.QUANTUM.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F843E3@ZURMSG1.QUANTUM.com>
	<20121030014218.GA26711@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=76770532f8=david.oshea@quantum.com>)
	id 1TcukU-0002jq-SB
	for lttng-dev@lists.lttng.org; Mon, 26 Nov 2012 04:13:06 -0500
In-Reply-To: <20121030014218.GA26711@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: Tuesday, 30 October 2012 12:12 PM
> To: David OShea
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] libust "Error: Error opening shm" every ~4
> seconds if HOME variable is not set
[...]
> Thanks for reporting! Can you try with stable-2.0 branch or master
> branch head ?
> 
> Here are the commits:
> 
> stable-2.0:
> 
> commit e699eda9762d3cf3b0c40329eb3b6ce0947789dc
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Mon Oct 29 21:39:42 2012 -0400
> 
>     Cleanup: don't spawn per-user thread if HOME is not set
> 
>     Reported-by: David OShea <David.OShea@quantum.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> master:
> 
> commit 9ec6895c5633ed93c5acdf1e5b06f075fbd709d3
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Mon Oct 29 21:39:42 2012 -0400
> 
>     Cleanup: don't spawn per-user thread if HOME is not set
> 
>     Reported-by: David OShea <David.OShea@quantum.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks for that!  Patching e699eda into the 2.0.5 release fixed the issue.

Regards,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
