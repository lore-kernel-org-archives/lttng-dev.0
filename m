From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RELEASE] LTTng Tools 2.2.0 - Cuda (STABLE)
Date: Wed, 26 Jun 2013 17:19:26 -0400
Message-ID: <20130626211926.GC4725__16401.6844625168$1372281597$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD131436D4@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130626124914.GA28225@Krystal> <20130626145505.GB30675@Krystal>
	<48CF5AC71E61DB46B70D0F388054EFFD131437FB@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Urx7f-0001vc-IL
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 17:19:27 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD131437FB@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> -----Message d'origine-----
> Per UID buffers makes every application sharing the same UID to use the s=
ame buffers.
> [...]
> Also, the buffers for UST application are now created in the consumer and=
 passed to the application. Thus, the buffer ownership has been transfered =
from the UST tracer to the consumer.
> -----Fin du message d'origine-----
> =

>    So what David really meant was:
> =

> Also, the per-PID buffers for UST application are now created in the cons=
umer and passed to the application. Thus, the buffer ownership has been tra=
nsferred from the UST tracer to the consumer in the per-PID case.

yes

> =

>    And I presume the per-UID buffers remain owned by the user-space-servi=
cing root consumer daemon?

yes, or whichever consumer daemon is used (e.g. per-user daemon if
sessiond is run as a simple user rather than as root)

>    When lttng is being run as an unprivileged user (and can thus trace
>    only user-space), setting the buffering scheme to per-UID would
>    mean the trace uid folder would have just one subfolder, the
>    unprivileged user's uid (e.g.
>    $HOME/lttng-traces/session-20130611-1223344/ust/uid/1000/64-bit),
>    right? =


yes

> I also presume the uid used is the real uid (ruid)?

yes, this is correct. The one returned by getuid().

Thanks,

Mathieu

> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> [Valcartier]\\vsi-wdut-o980, [Valcartier]\\edge
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
