From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Patches to enable building on CentOS 5.x (glibc	2.5)
Date: Mon, 8 Jul 2013 08:40:31 -0400
Message-ID: <20130708124031.GF21348__14855.8989669711$1373287273$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB23FDCE2B@ZURMSG1.QUANTUM.com>
	<CAEzWAeKCwo_OB=3LcDwrRw-NU3UTGbjtd+Hb82hMrj9fA5935w@mail.gmail.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB23FDDEC5@ZURMSG1.QUANTUM.com>
	<CAKPZSeBcWNgfzgNuk3eJkf_Ee+Qs4sLuwa1qmofrGOqELja5Hg@mail.gmail.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB23FDEE5A@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwAk7-0004Vj-Au
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 08:40:35 -0400
Content-Disposition: inline
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB23FDEE5A@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi David,

Yes, we could pull that as long as the patches are not intrusive.

We create "compat" wrappers for these things in the LTTng project. You
could create a include/compat/  and /compat  directories within
lttng-ust and put the files there.

Please see the babeltrace include/babeltrace/compat/*.h files as
examples. Similarly for lttng-tools src/common/compat/*.[ch].

Thanks,

Mathieu

* David OShea (David.OShea@quantum.com) wrote:
> Hi all,
> 
> Since there is more than one user interested in old glibc versions, does that mean we might be able to get the support into mainline?
> 
> Thanks in advance,
> David
> 
> > -----Original Message-----
> > From: yin sun [mailto:sunyin51@gmail.com]
> > Sent: Saturday, 18 May 2013 12:51 AM
> > To: David OShea
> > Cc: Brosseau, Yannick; lttng-dev@lists.lttng.org
> > Subject: Re: [lttng-dev] Patches to enable building on CentOS 5.x
> > (glibc 2.5)
> > 
> > Support lower version of glibc does provide value. In my case, it will
> > enable me easily port to existing production system, which is always
> > several versions behind.
> > 
> > Thanks,
> > /Yin
> > 
> > On Thu, May 16, 2013 at 11:52 PM, David OShea <David.OShea@quantum.com>
> > wrote:
> > > Hi Yannick,
> > >
> > >
> > >
> > > Yes, we patched the latest (as of around a month ago) versions to
> > work on
> > > CentOS 5.  Sorry, I neglected to mention that this is for UST only,
> > not
> > > kernel tracing, hence my not saying anything about the modules!
> > >
> > >
> > >
> > > If the changes aren't going to go upstream into the git repositories,
> > I
> > > imagine there is more chance of the CentOS 5 support becoming broken
> > -
> > > something could be committed upstream that requires further patching,
> > or
> > > conflicts with the patches.  In this case, then, I don't think EPEL
> > packages
> > > would help us much, and quite possibly nobody else is interested in
> > CentOS 5
> > > :)  Also, we needed to backport some lttng-ust commits from master to
> > get
> > > support for dynamic trace providers to work, so we're more interested
> > in
> > > seeing future releases include the changes than seeing a patched
> > version of
> > > the current release, and therefore I don't think there would be any
> > value in
> > > us moving to an EPEL package for the same version of LTTng that we're
> > > already using.
> > >
> > >
> > >
> > > I can certainly provide the patches to you anyway, but I'm not so
> > keen to
> > > spend time improving them if they're not going upstream, e.g. one
> > thing I
> > > think needs to be investigated is whether the kernel versions
> > provided by
> > > CentOS 5 include the system calls that we had to add wrappers for; I
> > haven't
> > > paid any attention to what kernel version I'm using, I'm not sure if
> > it is a
> > > standard CentOS 5 one.
> > >
> > >
> > >
> > > Thanks!
> > > David
> > >
> > >
> > >
> > >
> > >
> > > From: Brosseau, Yannick [mailto:yannick.brosseau@gmail.com]
> > > Sent: Friday, 17 May 2013 12:44 AM
> > > To: David OShea
> > > Cc: lttng-dev@lists.lttng.org
> > > Subject: Re: [lttng-dev] Patches to enable building on CentOS 5.x
> > (glibc
> > > 2.5)
> > >
> > >
> > >
> > > Hi,
> > >
> > > So you made it work with CentOS 5?
> > >
> > > I don't know if we want it upstream, but I could maybe use them to
> > build a
> > > package for EPEL5.
> > >
> > > Yannick
> > >
> > >
> > >
> > > On Wed, May 15, 2013 at 7:38 AM, David OShea
> > <David.OShea@quantum.com>
> > > wrote:
> > >
> > > Hi,
> > >
> > > Would contributions of patches to enable lttng-tools and lttng-ust to
> > build
> > > with glibc 2.5 (as is shipped with CentOS 5.x) and to enable lttng-
> > gen-tp to
> > > run with Python 2.4 (as shipped on CentOS 5.x) be accepted?
> > >
> > > What is missing from glibc 2.5 is:
> > >
> > > - a system call wrapper for sched_getcpu()
> > > - a system call wrapper for sync_file_range()
> > > - htobe32() and other similar endian conversion functions
> > >
> > > babeltrace and userspace-rcu did not require patching.
> > >
> > > Thanks in advance,
> > > David
> > >
> > > P.S. If you see this, thanks for all your recent replies, Mathieu, I
> > will
> > > try to get back to you soon!
> > >
> > > ---------------------------------------------------------------------
> > -
> > > The information contained in this transmission may be confidential.
> > Any
> > > disclosure, copying, or further distribution of confidential
> > information is
> > > not permitted unless such privilege is explicitly granted in writing
> > by
> > > Quantum. Quantum reserves the right to have electronic
> > communications,
> > > including email and attachments, sent across its networks filtered
> > through
> > > anti virus and spam software programs and retain such messages in
> > order to
> > > comply with applicable data security and retention requirements.
> > Quantum is
> > > not responsible for the proper and complete transmission of the
> > substance of
> > > this communication or for any delay in its receipt.
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> > >
> > >
> > >
> > > --
> > > Yannick Brosseau
> > > yannickbrosseau.com
> > >
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
