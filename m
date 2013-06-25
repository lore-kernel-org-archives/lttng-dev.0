From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Working with lttng enable-channel
Date: Tue, 25 Jun 2013 13:11:26 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1314339E__3237.97210953689$1372166979$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UrTIo-0000uf-QH
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 09:28:58 -0400
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
Message: 7
Date: Mon, 24 Jun 2013 17:28:26 +0300
From: Avi Goren <avi@reduxio.com>

I'm using lttng-ust and in the process of the attempt to gain some flush
frequency control I encountered a problem.
I'm having difficulties with the use of enable-channel.
it doesn't seem to apply property changes. here's an example:
-------------------------------------------------------------------------
# lttng create ses
Session ses created.
Traces will be written in /home/avig/lttng-traces/ses-20130624-163340
# lttng enable-event -a -u -s ses -c ch
All UST events are enabled in channel ch
# lttng disable-channel ch -u -s ses
UST channel ch disabled for session ses
# lttng enable-channel ch -u --subbuf-size 1024 --num-subbuf 1
UST channel ch enabled for session ses
# lttng list ses -c ch
Tracing session ses: [inactive]
    Trace path: /home/avig/lttng-traces/ses-20130624-163340

=3D=3D=3D Domain: UST global =3D=3D=3D

Buffer type: per PID

- ch: [enabled]

    Attributes:
      write mode: discard
      subbufers size: 4096 bytes
      number of subbufers: 4
      switch timer interval: 0 usec
      read timer interval: 0 usec
      output: mmap()

    Events:
      * (type: tracepoint) [enabled]

# lttng version
lttng version 2.2.0-rc2 - Cuda
...
-------------------------------------------------------------------------
Am I doing something wrong?
Is there a way to control flushing policy besides the use of enable-channel?
Thanks,
Avi
-----Fin du message d'origine-----

   From my dabbling with the buffers-pid and buffers-uid options, I strongl=
y suspect you need to enable the channel with its subbuf-size and num-subbu=
f options *before* using enable-event, otherwise enable-event creates the c=
hannel with a default configuration as a side effect.

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
