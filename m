From: David OShea <David.OShea@quantum.com>
Subject: Re: epoll_wait reboot kernel? [or --disable-epoll
 causes lttng-sessiond assert]
Date: Tue, 4 Mar 2014 00:50:59 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB2A67A66A__38652.57361108$1393894368$gmane$org@ZURMSG1.QUANTUM.com>
References: <c3d1fc94-92e2-43b3-af78-6315aaa7419d@aliyun.com,
	a860adc0-d68a-4a1e-bbd1-775c1cf652e9@aliyun.com>
	<494972cb-79c7-4197-981c-d682306d585e@aliyun.com>
	<6cab5c14-9ef8-4a13-a134-a4b628ddc35d@aliyun.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB2A67A4EE@ZURMSG1.QUANTUM.com>
	<20140303144322.GA7842@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=3140c07013=david.oshea@quantum.com>)
	id 1WKdZf-0001iO-Bt
	for lttng-dev@lists.lttng.org; Mon, 03 Mar 2014 19:51:16 -0500
In-Reply-To: <20140303144322.GA7842@thessa>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> -----Original Message-----
> From: David Goulet [mailto:dgoulet@efficios.com]
> Sent: Tuesday, 4 March 2014 1:13 AM
> To: David OShea
> Cc: zhenyu.ren; Mathieu Desnoyers; lttng-dev
> Subject: Re: [lttng-dev] epoll_wait reboot kernel? [or --disable-epoll
> causes lttng-sessiond assert]
> 
> On 03 Mar (10:17:11), David OShea wrote:
> > Hi all,
> >
> > Apologies if I'm confusing things, but I think my issue may be
> related.  Please see below:
> >
> > > -----Original Message-----
> > > From: zhenyu.ren [mailto:zhenyu.ren@aliyun.com]
> > > Sent: Tuesday, 25 February 2014 4:32 PM
> > > To: Mathieu Desnoyers
> > > Cc: lttng-dev
> > > Subject: Re: [lttng-dev] epoll_wait reboot kernel?
> > >
> > > >Which gcc version do you use ?
> > > $gcc --version
> > > gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-46)
> >
> > I'm on CentOS 6, so my results ought to be relevant, but the above
> looks like the default GCC version for EL5, not EL6.  I'm using "gcc
> (GCC) 4.4.7 20120313 (Red Hat 4.4.7-4)".
> >
> > [...]
> > > >  >  I am working on rhel6(2.6.32.220) and ust is working very
> > > well.But when I
> > > >  >  use lttng-modules (after "lttng start"),the kernel reboots
> > > immediately
> > > >  >  >without any message output to console.
> >
> > I'm not using the kernel modules here, just lttng-ust.
> >
> > [...]
> > > > > I want to use poll instead as epoll in lttng-tools ,I changed
> > > lttng-tools
> > > > > configure file to not use epoll(undef HAVE_EPOLL),
> >
> > Note that 'configure' for lttng-tools has a --disable-epoll option.
> >
> > > > > but "lttng enable-event
> > > > > -a -k >"failed :(Do I miss anything?)
> > > > >#lttng enable-event -a -k
> > > > >DEBUG1 [17837/18080]: Using run_as_clone (in run_as() at
> > > runas.c:293)
> > > > >lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion
> > > `pollfd ==
> > > > >ht_cleanup_pipe[0]' failed.
> >
> > I get similar issues when I run 'lttng enable-event -a -u' (i.e. UST
> instead of kernel tracing):
> >
> > DEBUG1 [1292/1297]: Spawning consumerd (in spawn_consumerd() at
> main.c:2085)
> > lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion `pollfd
> == ht_cleanup_pipe[0]' failed.
> > DEBUG1 [1329/1329]: Using 64-bit UST consumer at:
> /usr/lib64/lttng/libexec/lttng-consumerd (in spawn_consumerd() at
> main.c:2161)
> > Aborted (core dumped)
> 
> Can you open a bug at bugs.lttng.org about that (if not already done)
> and provide the "bt full" of your coredump. That would be very helpful
> to us to address this issue.

Please see https://bugs.lttng.org/issues/747

Thanks!
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
