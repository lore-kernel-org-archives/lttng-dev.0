From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng / Android questions
Date: Thu, 2 Aug 2012 17:52:50 -0400
Message-ID: <20120802215250.GB29960__48763.8780534782$1343944400$gmane$org@Krystal>
References: <DB3D54B734896D4E8E7126869751E3AE284D15F4@ORSMSX102.amr.corp.intel.com>
	<20120724182031.GB2285@Krystal>
	<DB3D54B734896D4E8E7126869751E3AE284E87EF@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sx3K9-000633-HH
	for lttng-dev@lists.lttng.org; Thu, 02 Aug 2012 17:52:53 -0400
Content-Disposition: inline
In-Reply-To: <DB3D54B734896D4E8E7126869751E3AE284E87EF@ORSMSX101.amr.corp.intel.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Glossop, Kent" <kent.glossop@intel.com>, Karim Yaghmour <karim.yaghmour@opersys.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Karim,

Any word of advice about building LTTng 2.0 on Android ? See the
question below.

Thanks,

Mathieu

* Glossop, Kent (kent.glossop@intel.com) wrote:
> Thanks.
> 
> I've been trying to understand how to do the lttng cross build for
> Android.  Is there a particular approach that you would expect people
> to most naturally use (e.g. if I were to write up a "how-to")?
> It seems like one approach is to use a full Android build area, adding
> the lttng components to the "external" directory, requiring Android.mk
> files.  If the files aren't generated automatically, this adds
> maintenance.  (There is a tool called androgenizer that can be used
> assist, but that seems undesirable to include for a "general"
> solution.)  Another approach would be to build some of components with
> options to configure, in conjunction with an Android build (or NDK?)
> area.  Would you view one of these (or something else), a "preferred"
> way?
> 
> Thanks,
> Kent
> 
> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] 
> Sent: Tuesday, July 24, 2012 2:21 PM
> To: Glossop, Kent
> Cc: christian.babeux@efficios.com
> Subject: Re: LTTng / Android questions
> 
> Hi Kent,
> 
> It should work, theoretically. Testing would be welcome. We did port of the lttng tools (except for the kernel tracer) to NetBSD/FreeBSD recently, where we had to circumvent lack of TLS support, so this requirement on the glibc is now gone from the 2.0 lttng series.
> 
> If Android kernel is close enough to mainline, lttng-modules should work too.
> 
> I'm CCing christian, who is currently looking at the embedded aspect of the continuous integration heterogenous cluster we are currently building.
> 
> Thanks,
> 
> Mathieu
> 
> 
> * Glossop, Kent (kent.glossop@intel.com) wrote:
> > Mathieu,
> > 
> > I'm interested in LTTng for Android.  If you have time, a few 
> > questions...  (Let me know if this would be better posted to 
> > lttng-dev.)
> > 
> > From what I can tell from previous postings to lttng-dev and other places:
> > 
> > -          People apparently used a previous version with a 2.x kernel with some changes and building it in
> > 
> > -          There was/is an issue with glibc vs. bionic for lttng's use of shared memory
> > 
> > -          Back in Feb. there was a demo done of LTTng on Android done using a copy of glibc
> > 
> > -          There are at least some changes being made that mention Android (e.g. a TLS change that mentioned Android about 2 months ago)
> > 
> > What I'm interested in:
> > 
> > -          Are there directions somewhere for building LTTng for use with Android?  (e.g. how to configure component and reference an Android build area rather than things for the native host?)
> > 
> > -          How much is expected to work on Android?
> > 
> > -          Is glibc still needed?
> > 
> > -          Are there people actively working on Android support (if it doesn't already work)?
> > 
> > -          Do you have a rough idea what might be involved for an Android x86 version beyond arm?
> > 
> > Ideally, I would like to be able to install a minimal set of pieces, preferably on to a stock phone, collect LTTng traces, and use the viewer on linux (or maybe even windows if linux-tools works there.)  Then, to do that with x86 Android in addition to arm...
> > 
> > Thanks,
> > Kent Glossop, Intel
> > 
> 
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
