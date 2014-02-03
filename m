From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Questions about JUL (was:  lttng-dev Digest, Vol 67,
 Issue 48)
Date: Mon, 3 Feb 2014 15:36:14 +0000 (UTC)
Message-ID: <1953408834.17890.1391441774252.JavaMail.zimbra__18991.6766169064$1391441838$gmane$org@efficios.com>
References: <mailman.1320.1384681007.2186.lttng-dev@lists.lttng.org>
	<63008C666A72BB4F892767155D012B30390BFB4D@eusaamb105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WALZN-0004N9-Eo
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 10:36:29 -0500
In-Reply-To: <63008C666A72BB4F892767155D012B30390BFB4D@eusaamb105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jim Dumont <jim.dumont@ericsson.com>, David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Jim,

I'm CCing David on this one. He will answer as soon
we he gets back from FOSDEM (and recovers from jet lag). ;-)

Note to Daniel: please don't reply to a mailing list digest. It's a
very good way to have an email ignored as "TL;DR".

Thanks!

Mathieu

----- Original Message -----
> From: "Jim Dumont" <jim.dumont@ericsson.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, January 17, 2014 12:26:13 PM
> Subject: Re: [lttng-dev] lttng-dev Digest, Vol 67, Issue 48
> 
> Hi there,
> 
> Was there a follow-up to the series of questions raised by Daniel below and
> referenced here:
> 
> http://lists.lttng.org/pipermail/lttng-dev/2013-November/021844.html
> 
> I didn't see one in the mailing list.
> 
> BR,
> 
> /Jim
> 
[...]
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Fri, 15 Nov 2013 20:22:34 +0000
> From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
> To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
> Subject: Re: [lttng-dev] [RELEASE] LTTng-Tools 2.4.0-rc1 - ?poque
> 	Opaque
> Message-ID:
> 	<48CF5AC71E61DB46B70D0F388054EFFD267A2503@VAL-E-01.valcartier.drdc-rddc.gc.ca>
> 	
> Content-Type: text/plain; charset="iso-8859-1"
> 
> -----Message d'origine-----
> Date: Fri, 15 Nov 2013 12:27:01 -0500
> From: David Goulet <dgoulet@efficios.com>
> 
> > 1) Live support. It's now possible to stream traces (kernel and UST)
> > while they being extracted meaning a relayd can now receive traces
> > live and a viewer can attach to it to process the trace while running.
> > The "--live" has been added to lttng create command that sets up a
> > live tracing session.
> >
> > See doc/live-reading-howto.txt and doc/live-reading-protocol.txt for
> > more detail on that feature.
> 
>    Does this mean you can't do a "live" trace to local storage?
> 
> > 2) Java Util Logging support. With a special LTTngAgent located in
> > lttng-ust project (liblttng-ust-jul) to trace JUL events and gather
> > UST traces with them.
> >
> > The -j/--jul domain has been added to lttng command line so you can
> > list the possible JUL Logger object and enable/disable them. It is the
> > same as using the UST or Kernel domain.
> >
> > As of now, filters and loglevel are ignored with the JUL domain.
> 
>    Saying "It is the same as using the UST or Kernel domain" leaves a lot of
>    questions unanswered, since the kernel and user-space behave *very*
>    differently on a lot of points.
> 
> 1) Does --jul require root privileges?
> 2) I suppose the various commands have --kernel pre-empting --userspace
> pre-empting --ul?
> 3) add-context: does --jul have the same possible context types as
> --userspace (i.e. ip, pthread_id, procname, vpid, vtid)?
> 4) enable-channel:
> 4.1) Are the --jul --subbuf-size, --num-subbuf and --read-timer defaults the
> same as with --userspace?
> 4.2) Presumably --output can only be mmap?
> 4.3) Are the --jul buffering schemes the same as with --userspace (i.e.
> --buffers-pid and --buffers-uid)?
> 4.4) If yes, won't they all degenerate to the virtual machine's user and
> process IDs?
> 5) enable-event:
> 5.1) Can you assign --jul events to multiple channels like you can in
> --userspace?
> 5.2) Is the --jul event type --tracepoint or something else entirely?
> 5.3) Can the trailing wild card (and exclusion option) be used in the event
> name when enabling/disabling --jul events?
> 6) list: Does bug #654 also apply to --jul?
> 
> Daniel U. Thibault
> Protection des syst?mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC) Cyber s?curit? pour les missions essentielles (CME) |
> Mission Critical Cyber Security (MCCS) R & D pour la d?fense Canada -
> Valcartier (RDDC Valcartier) | Defence R&D Canada - Valcartier (DRDC
> Valcartier)
> 2459 route de la Bravoure
> Qu?bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
