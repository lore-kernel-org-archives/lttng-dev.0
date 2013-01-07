From: David OShea <David.OShea@quantum.com>
Subject: Re: babletrace with python bindings
Date: Mon, 7 Jan 2013 04:40:03 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F8ABF4__38153.0875726186$1357533658$gmane$org@ZURMSG1.QUANTUM.com>
References: <20121218184045.288000@gmx.com> <20121219183932.GA9587@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=9719282f64=david.oshea@quantum.com>)
	id 1Ts4VQ-0003J0-Jw
	for lttng-dev@lists.lttng.org; Sun, 06 Jan 2013 23:40:12 -0500
In-Reply-To: <20121219183932.GA9587@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, ajonwa ajonwa <ajonwa@gmx.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: Thursday, 20 December 2012 5:10 AM
> To: ajonwa ajonwa
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] babletrace with python bindings
> 
> * ajonwa ajonwa (ajonwa@gmx.com) wrote:
> > Hello everyone,
> >
> >  I get the following error message while attempting to compile
> babeltrace with python bindings:
[...]
> This branch is currently in development, and might be out of sync with
> the master branch of babeltrace at the moment. We don't have immediate
> plans to work on it, but bontributions are welcome.

Apologies for the late reply.  I just wanted to point out that if you check out commit 24a3136a383, it does build.  It's an older version of babeltrace, but does work despite some bugs.

The main bug I recall is that iterator.set_pos(babeltrace.IterPos(babeltrace.SEEK_BEGIN)) doesn't fail immediately, and works in some traces, but sometimes results in a subsequent assertion failure in the Python interpreter after a few events have been read, or returns a bogus event at the start of the trace.  Quite possibly this is a babeltrace bug that has been fixed already. 

Regards,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
