From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: infinite loop invoked using lttng
	enable/disable-event
Date: Tue, 25 Jun 2013 19:01:21 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD13143525__5241.2602854476$1372187007$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UrYVp-0003ea-UR
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 15:02:46 -0400
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
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Date: Tue, 25 Jun 2013 09:49:36 +0300
From: Avi Goren <avi@reduxio.com>

I'm using lttng 2.2.0 and encountered an infinite loop:
-------------------------------------------------------------------------
# lttng create
Session auto-20130624-165047 created.
Traces will be written in /home/avig/lttng-traces/auto-20130624-165047
# lttng enable-event -a -u --loglevel TRACE_ALERT
All UST events are enabled in channel channel0 for loglevel TRACE_ALERT
# lttng enable-event -a -u --loglevel TRACE_CRIT
All UST events are enabled in channel channel0 for loglevel TRACE_CRIT
# lttng disable-event -a -u
All UST events are disabled in channel channel0
# lttng enable-event -a -u --loglevel TRACE_CRIT
All UST events are enabled in channel channel0 for loglevel TRACE_CRIT
# lttng disable-event -a -u
(infinite loop here...)
-------------------------------------------------------------------------
I guess it's probably due to the setting of loglevel through enable-event t=
wice..?
Avi
------------------------------

   I've reproduced it with one less step:

# lttng create loop
Session loop-20130624-165047 created.
Traces will be written in /home/avig/lttng-traces/loop-20130624-165047
# lttng enable-event -a -u --loglevel TRACE_ALERT
All UST events are enabled in channel channel0 for loglevel TRACE_ALERT
# lttng disable-event -a -u
All UST events are disabled in channel channel0
# lttng enable-event -a -u --loglevel TRACE_CRIT
All UST events are enabled in channel channel0 for loglevel TRACE_CRIT
# lttng list loop
(...)
    Events:
      * (loglevel: TRACE_CRIT (2)) (type: tracepoint) [enabled]
      * (loglevel: TRACE_ALERT (1)) (type: tracepoint) [disabled]
# lttng disable-event -a -u
(LTTng hangs here)

   Remarkably, the session daemon remains very busy after the sudo kill com=
mand is sent, even though the trace has not even been started!  It refuses =
to die and I had to restart the system.  I'll post the bug up (with the ses=
sion daemon log) shortly.

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
