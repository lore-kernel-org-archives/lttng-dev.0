From: "Wolfgang Rostek" <wolfgang.rostek@gmx.de>
Subject: Re: major variations in perfomance figures
Date: Fri, 3 Apr 2015 17:34:44 +0200
Message-ID: <trinity-a202c764-638a-4c9a-b09f-c588cfe2cdb8-1428075284708__24167.7028978758$1428075344$gmane$org@3capp-gmx-bs13>
References: <trinity-1e9921b3-666b-4656-bcb8-a2125944698f-1427831168919@3capp-gmx-bs39>
 <CA+jJMxuEdC4aaAZci3rwWM3sGJbyqchBeuVG2iTM5Ag11zKPwg@mail.gmail.com>
 <trinity-44577199-4bb4-4bf1-8595-785637f25968-1428072450572@3capp-gmx-bs60>,
 <CA+jJMxuOT-zRW4k74C-gD3n4XP3mWO4HGYCLu=LT+EnMuRncAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wolfgang.rostek@gmx.de>) id 1Ye3cQ-0003sr-O5
 for lttng-dev@lists.lttng.org; Fri, 03 Apr 2015 11:34:53 -0400
In-Reply-To: <CA+jJMxuOT-zRW4k74C-gD3n4XP3mWO4HGYCLu=LT+EnMuRncAQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?=22J=C3=A9r=C3=A9mie_Galarneau=22?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

...
> > Frequence scaling I can't imagine on my dektop machine.
> > It is a jump between 350ns and 800ns. In the loop below
> > all the events of one test run are of equal time distance,
> > either slow or fast.
> 
> Frequency scaling can still definitely play a role, even on a desktop machine.
> Also, Core i5 chips support Turbo Boost which should be disabled to
> perform benchmarks.
> 
> I'm guessing you get your time measurements from the timestamps in the
> trace?
Yes

I'm not hunting for a detailed benchmark. Only such a large variance makes
me thoughtful. For such a test I did expect some 10-30% but not this more 
than 200%.

Wolfgang R.
