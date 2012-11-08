From: David Bryant <david.bryant@quantum.com>
Subject: Re: Fix filter: pointer to string, not string,
 should be on stack -- query
Date: Thu, 8 Nov 2012 11:03:41 +1030
Message-ID: <509AFDE5.8090309__17524.761791765$1352334868$gmane$org@quantum.com>
References: <509A0F80.1070308@quantum.com> <20121107183400.GA29766@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=76591ce31e=david.bryant@quantum.com>)
	id 1TWG46-00060g-DC
	for lttng-dev@lists.lttng.org; Wed, 07 Nov 2012 19:33:50 -0500
In-Reply-To: <20121107183400.GA29766@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Yes, your commit did the trick! My patched version of easy-ust (that 
passed an lvalue string) compiles and runs correctly.

$ lttng view
Trace directory: /home/dbryant/lttng-traces/sample-20121108-105753

[10:59:16.175851994] (+?.?????????) sample:3213 
sample_component:message: { cpu_id = 0 }, { message = "Hello World" }
[10:59:17.176018865] (+1.000166871) sample:3213 
sample_component:message: { cpu_id = 0 }, { message = "Hello World" }
[10:59:18.176188138] (+1.000169273) sample:3213 
sample_component:message: { cpu_id = 0 }, { message = "Hello World" }

Thanks for your quick response!

Dave

On 08/11/12 05:04, Mathieu Desnoyers wrote:
> Hello !
>
> Please upstream lttng-ust master branch HEAD, which includes this
> commit:
>
> commit c4261b0aecaf281fc1ced4c7af96b1ff6d2600d7
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Nov 7 13:24:58 2012 -0500
>
>      Fix: re-allow non-lvalue string, sequence, array parameters
>      
>      Issue introduced by upstream commit:
>      
>        commit 27f4b6094f399f2fe231b58801dce98cbd21baa9
>        Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>        Date: Tue Sep 4 12:17:07 2012 -0400
>      
>        Fix filter: pointer to string, not string, should be on stack
>      
>        Fixes #329
>      
>      Reported-by: David Bryant <david.bryant@quantum.com>
>      Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Please let me know if it helps,
>
> Thanks,
>
> Mathieu
>

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
