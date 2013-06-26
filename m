From: David OShea <David.OShea@quantum.com>
Subject: Re: Problem with adding vpid and vtid context to UST
Date: Wed, 26 Jun 2013 10:53:12 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB23FEF65A__35813.3380687379$1372244056$gmane$org@ZURMSG1.QUANTUM.com>
References: <OFA2B17967.FDD790B6-ONC2257B8C.002C000A-C2257B8C.002C70E3@il.ibm.com>
	<51BF6B2C.1060509@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=488976b6d0=david.oshea@quantum.com>)
	id 1UrnM1-0003Bz-Jf
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 06:53:37 -0400
In-Reply-To: <51BF6B2C.1060509@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>, Amit Margalit <AMITM@il.ibm.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> -----Original Message-----
> From: David Goulet [mailto:dgoulet@efficios.com]
> Sent: Tuesday, 18 June 2013 5:32 AM
> To: Amit Margalit
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Problem with adding vpid and vtid context to
> UST
> 
> Hi Amit,
> 
> Amit Margalit:
> > Hi,
> >
> > Every time I try this, I get the following error:
> >
> > Error: Error starting tracing for app pid: 5663 (ret: -1027)
> >
> > Here's my sequence:
> >
> > lttng create foo -o /store/
> > lttng enable-channel -u
> > lttng add-context -u -t vpid -t vtid -t procname
> > lttng enable-event -u -a
> > lttng start foo
> >
> > At this point I start my application and get that error. When the
> application
> > exits, I stop the tracing, and run lttng view.
> >
> > The trace session seems to have worked just fine, and "procname" was
> indeed
> > added to the context, but vtid and vpid were not.
> 
> What's going on here is that you enable a channel then add contexts.
> This is
> perfectly OK (although your example is missing a channel name). So, the
> following "lttng enable-event" creates a default channel "channel0"
> since no
> "-c" was specified.
> 
> So basically, the contexts are available on the first channel and not
> the second
> one.

Not that it's very important, but another option: aside from the missing channel name, I've used the above sequence of commands with both LTTng 2.0.x and 2.1.x with success.  For 'enable-channel', I specified the channel name "channel0" so that the context was added to the same channel that the subsequent 'enable-event' acted on.
 
Regards,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
