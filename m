From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re:
 =?iso-8859-1?q?=5BRELEASE=5D_LTTng-Tools_2=2E4=2E0-rc?=
 =?iso-8859-1?q?1_-_=C9poque_Opaque?=
Date: Fri, 15 Nov 2013 20:22:34 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A2503__17909.6372602091$1384547015$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VhPuW-0007Je-S2
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 15:22:42 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Date: Fri, 15 Nov 2013 12:27:01 -0500
From: David Goulet <dgoulet@efficios.com>

> 1) Live support. It's now possible to stream traces (kernel and UST)
> while they being extracted meaning a relayd can now receive traces live
> and a viewer can attach to it to process the trace while running. The
> "--live" has been added to lttng create command that sets up a live
> tracing session.
>
> See doc/live-reading-howto.txt and doc/live-reading-protocol.txt for
> more detail on that feature.

   Does this mean you can't do a "live" trace to local storage?

> 2) Java Util Logging support. With a special LTTngAgent located in
> lttng-ust project (liblttng-ust-jul) to trace JUL events and gather UST
> traces with them.
>
> The -j/--jul domain has been added to lttng command line so you can list
> the possible JUL Logger object and enable/disable them. It is the same
> as using the UST or Kernel domain.
>
> As of now, filters and loglevel are ignored with the JUL domain.

   Saying "It is the same as using the UST or Kernel domain" leaves a lot o=
f questions unanswered, since the kernel and user-space behave *very* diffe=
rently on a lot of points.

1) Does --jul require root privileges?
2) I suppose the various commands have --kernel pre-empting --userspace pre=
-empting --ul?
3) add-context: does --jul have the same possible context types as --usersp=
ace (i.e. ip, pthread_id, procname, vpid, vtid)?
4) enable-channel:
4.1) Are the --jul --subbuf-size, --num-subbuf and --read-timer defaults th=
e same as with --userspace?
4.2) Presumably --output can only be mmap?
4.3) Are the --jul buffering schemes the same as with --userspace (i.e. --b=
uffers-pid and --buffers-uid)?
4.4) If yes, won't they all degenerate to the virtual machine's user and pr=
ocess IDs?
5) enable-event:
5.1) Can you assign --jul events to multiple channels like you can in --use=
rspace?
5.2) Is the --jul event type --tracepoint or something else entirely?
5.3) Can the trailing wild card (and exclusion option) be used in the event=
 name when enabling/disabling --jul events?
6) list: Does bug #654 also apply to --jul?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
