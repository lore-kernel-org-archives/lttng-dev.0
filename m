From: David OShea <David.OShea@quantum.com>
Subject: Re: Wrong procname for userspace trace of app
	with	different thread names
Date: Thu, 25 Oct 2012 04:07:54 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F81C78__3088.23346063054$1351138117$gmane$org@ZURMSG1.QUANTUM.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F7CBC4@ZURMSG1.QUANTUM.com>
	<20121024123207.GA9568@Krystal> <20121024123551.GB9568@Krystal>
	<20121024130601.GA10310@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=664505c6d1=david.oshea@quantum.com>)
	id 1TREjh-00074S-Ou
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 00:08:01 -0400
In-Reply-To: <20121024130601.GA10310@Krystal>
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
> Sent: Wednesday, 24 October 2012 11:36 PM
> To: David OShea
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Wrong procname for userspace trace of app with
> different thread names


> > I expect that typical use-cases involve calling prctl right after the
> > thread starts, so it might just work (this would need to be
> documented
> > though).
> 
> Please try with lttng-ust HEAD, which includes: [...]
> 
> commit 009745db8ca05f7a3abbb37558b08eae0107f7e1

Thanks, I just applied that commit as a patch to the older version of lttng-ust I'm using and it works as desired!  I think the assumption that prctl() is called right after the thread starts is a reasonable one.


> > > > Incidentally, why do I have to do "enable-channel" to get the context
> > > > to actually appear?  If I don't do this, the "add-context" still says
> > > > that each of the four contexts was "added to all channels", but they
> > > > don't appear in 'lttng view'.
> > >
> > > Please provide the full list of commands you do to reproduce a "good"
> > > and "bad" behavior.

Thanks, I'll do a few tests and make a separate post about this.

Regards,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
