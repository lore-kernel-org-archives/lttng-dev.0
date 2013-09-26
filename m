From: Julien Desfossez <julien.desfossez@efficios.com>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 11:21:44 -0400
Message-ID: <52445108.4040505__49346.3186467581$1380208969$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793763@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <julien.desfossez@efficios.com>) id 1VPDO4-0000dj-O9
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 11:21:58 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26793763@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

On 13-09-25 05:31 PM, Thibault, Daniel wrote:
>    Conversely, if the session daemon catches up to the consumer daemon du=
ring an 'lttng snapshot record' action, what happens?  Does the session dae=
mon wait for the consumer to be done?  Does the session daemon force the co=
nsumer to wrap up prematurely?  (Assuming flight recorder mode, of course)
Already answered in my previous mail.

> =

>    If a snapshot session is in discard mode, am I right in supposing it j=
ust stops tracing once the buffers are full?  Does a record action "clear" =
the buffers for re-use then?
No, currently there is no way to clear the ring buffer for reuse, so
indeed in discard mode once the buffer is full, it stops recording
events. That is why we default to override mode (flight recorder) in
snapshot.

Thanks,

Julien

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
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
