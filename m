From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Compile failure on OSX 10.8
Date: Mon, 8 Jul 2013 12:24:02 -0400
Message-ID: <20130708162402.GR29362__24579.9410426573$1373300676$gmane$org@Krystal>
References: <51C46FFC.7050407@ripe.net>
	<CAGDH53k9wAeu6cBsSCtauX0ADgFW9B09vz7Cfq2B=Yhw3-pCNw@mail.gmail.com>
	<51C47EE0.9080208@ripe.net>
	<CAGDH53mD-8jWechmKhVWyS7nY_CJQQgdDXfLp1V=gsAkmw53eQ@mail.gmail.com>
	<51C49E0C.8020808@ripe.net> <51CB0DAF.6010507@ripe.net>
	<CAGDH53n_rqWRnYgKybz6FTbjQZrRyj-QMKDkR+KWJhA0gxGEnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwEEO-0006Wz-Hi
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 12:24:04 -0400
Content-Disposition: inline
In-Reply-To: <CAGDH53n_rqWRnYgKybz6FTbjQZrRyj-QMKDkR+KWJhA0gxGEnQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Documented in README file:

commit 9e6b9f8afa8e70854a4e09e326de45dbd7e63bef
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Jul 8 12:22:00 2013 -0400

    Document build work-around on MacOS X
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


* Christian Babeux (christian.babeux@efficios.com) wrote:
> Hi Anand,
> 
> I've opened a bug for this issue [1]. My first diagnostic was incorrect.
> Configure detect the CPU as a 386, which is quite wrong. This in turns
> cause a lot of issues :
> 
> This enable the x86 compat layer in liburcu which in turns barf on these:
> 
> __asm__ __volatile__ ("pushfl; popl %0" : "=r" (res) : );
> 
> [...]
> 
> __asm__ __volatile__ ("pushl %0; popfl" : : "r" (newflags) : "cc");
> 
> 
> The compiler on Mac OSX has specifically been compiled to run on
> x86_64 (seen in config.log, --host=x86_64-apple-darwin11). The pushfl,
> popfl instructions are not present on x86_64, so the assembler
> fails...
> 
> The workaround would be to force the build/host flag at configure time
> to this (similar to [2]) :
> 
> ./configure --build=x86_64-apple-darwin11
> 
> We will have to either fix this in the configure.ac script or document this bug.
> 
> Christian
> 
> 
> [1] - http://bugs.lttng.org/issues/578
> [2] - https://trac.macports.org/ticket/21011
> 
> On Wed, Jun 26, 2013 at 11:50 AM, Anand Buddhdev <anandb@ripe.net> wrote:
> > Hi Christian,
> >
> > Were you able to figure out from the config.log files why the
> > architecture detection wasn't working properly?
> >
> > Anand
> >
> > On 21/06/2013 20:40, Anand Buddhdev wrote:
> >
> >> Hi Christian,
> >>
> >> I've attached both here.
> >>
> >> Anand
> >>
> >> On 21/06/2013 18:51, Christian Babeux wrote:
> >>
> >>> Hmm that's really weird :/. For some reason configure detect an i386
> >>> CPU which is certainly not right. Could you post your config.log with
> >>> and without the --host flag (specifying which is which)?
> >>>
> >>> There might be some slight incompatibilities on OSX and the CPU
> >>> detection mechanism we are using...
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
