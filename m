From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [rp] [PATCH] Ensure that read-side functions meet
 10-line LGPL criterion
Date: Sun, 2 Sep 2012 14:19:24 -0700
Message-ID: <20120902211923.GC9534__39440.1205973283$1346620802$gmane$org@leaf>
References: <20120902005911.GA26326@linux.vnet.ibm.com>
	<20120902051355.GA7767@leaf>
	<20120902160733.GZ30381@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <josh@joshtriplett.org>) id 1T8HZu-0006KR-78
	for lttng-dev@lists.lttng.org; Sun, 02 Sep 2012 17:19:34 -0400
Content-Disposition: inline
In-Reply-To: <20120902160733.GZ30381@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, eag0628@gmail.com, mathieu.desnoyers@efficios.com, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On Sun, Sep 02, 2012 at 09:07:33AM -0700, Paul E. McKenney wrote:
> On Sat, Sep 01, 2012 at 10:13:55PM -0700, Josh Triplett wrote:
> > On Sat, Sep 01, 2012 at 05:59:11PM -0700, Paul E. McKenney wrote:
> > > This commit ensures that all read-side functions meet the 10-line LGPL
> > > criterion that permits them to be expanded directly into non-LGPL code,
> > > without function-call instructions.  It also documents this as the intent.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > s/directloy/directly/g in the comments.
> 
> Good catch, fixed.
> 
> > Also, this seems inordinately silly. :)
> > 
> > Assuming you don't plan to copy other LGPLed code into this library (or
> > more specifically the header file), you might consider just adding an
> > explicit exception at the top, saying that the inline functions in this
> > file may be assumed to qualify for the relevant clause of the LGPL,
> > regardless of their length.  (You'd probably want to limit that
> > exception to only the code in the header, not any other code in the
> > library, so someone couldn't just copy the whole library into the
> > headers.)
> 
> I believe that it is important to allow LGPL code to flow easily between
> these headers and other LGPL projects.  This commit represents a trivial
> change, admittedly, but one that could save a large amount of bookkeeping
> and license-compatibility hassle down the road.

Fair enough.

Incidentally, LGPLv3 (specifically, clause 3) seems much saner in this
regard: exceeding the ten-line limit doesn't cause any issue other than
needing to include a copy of the license and give notice about the usage
of the library, which you'd have to do anyway when linking to the
library.

Of course, LGPLv3 wouldn't necessarily satisfy your goal of
interoperability with other LGPL (v2.1) projects.

- Josh Triplett
