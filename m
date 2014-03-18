From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Trace rotation across sessions
Date: Tue, 18 Mar 2014 15:07:38 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD31A68169__17193.827025085$1395155333$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WPvcI-0002Rl-0E
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 11:07:51 -0400
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

----------------------------------------------------------------------
Date: Tue, 18 Mar 2014 10:19:47 -0400
From: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>

> On Tue, Mar 18, 2014 at 4:52 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> > Our system has a running session that stays on continuously.
>>
> > Occasionally, our customer will upgrade the software, leading to a =

> > reboot, which in turn means we will have a new session.
> >
> > Is there any way to make LTTng aware of the total size of all sessions =

> > (current and past) and simply rotate files to keep the entire set of =

> > traces under a size limit?
>
> The only way I can see this working is by recreating the same session con=
figuration
> (with the same output destination) and using lttng enable-channel's -C (t=
racefile-size) =

> and -W (tracefile-count) options to define an upper bound on each trace's=
 size.
>
> Is this what you are looking for?
>
> J?r?mie Galarneau
> EfficiOS Inc.

   Wouldn't that just overwrite the destination trace files?

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
