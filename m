From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Re: Working on some bugs
Date: Wed, 12 Mar 2014 22:59:20 -0700
Message-ID: <CAEEAEzXcwbJbv_izsQjL9VTUja2kUj+d_r9iufeqSN4GJvV4Fg__4231.87940982661$1394690405$gmane$org@mail.gmail.com>
References: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
	<20140311162201.GE7727@thessa>
	<CAEEAEzX3KOz0JDGGee20f2CBtFuPhrRUX2m2hzhut5WObGVBuw@mail.gmail.com>
	<20140312142646.GA10776@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1380079137=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <babbusandy2006@gmail.com>) id 1WNyfu-0007vc-4r
	for lttng-dev@lists.lttng.org; Thu, 13 Mar 2014 01:59:27 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so542827qaq.36
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 22:59:20 -0700 (PDT)
In-Reply-To: <20140312142646.GA10776@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1380079137==
Content-Type: multipart/alternative; boundary=001a1137087c7f9eb504f476a789

--001a1137087c7f9eb504f476a789
Content-Type: text/plain; charset=ISO-8859-1

Thanks for pointing it to me, David !

However I see the following in relay_add_stream in main.c

        switch (conn->minor) {
        case 1: /* LTTng sessiond 2.1 */
                ret = cmd_recv_stream_2_1(conn, stream);
                break;
        case 2: /* LTTng sessiond 2.2 */
        default:
                ret = cmd_recv_stream_2_2(conn, stream);
                break;
        }

This means that it's calling either 'cmd_recv_stream_2_1' or
'cmd_recv_stream_2_2' depending on the minor version number. Is this not we
want? Though I don't understand why it should be calling
'cmd_recv_stream_2_2' for minor versions other than 1. Is this correct
behavior?

Please let me know.

Thanks and regards,
Sandeep.

--001a1137087c7f9eb504f476a789
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for pointing it to me, David !=A0<div><br></div><di=
v>However I see the following in=A0relay_add_stream in main.c</div><div><br=
></div><div><div>=A0 =A0 =A0 =A0 switch (conn-&gt;minor) {</div><div>=A0 =
=A0 =A0 =A0 case 1: /* LTTng sessiond 2.1 */</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cmd_recv_stream_2_1(conn, stre=
am);</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;</div><div>=A0 =A0 =A0=
 =A0 case 2: /* LTTng sessiond 2.2 */</div><div>=A0 =A0 =A0 =A0 default:</d=
iv><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cmd_recv_stream_2_2(conn, s=
tream);</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;</div><div>=A0 =A0 =A0 =A0 }</di=
v></div><div><br></div><div>This means that it&#39;s calling either &#39;cm=
d_recv_stream_2_1&#39; or &#39;cmd_recv_stream_2_2&#39; depending on the mi=
nor version number. Is this not we want? Though I don&#39;t understand why =
it should be calling &#39;cmd_recv_stream_2_2&#39; for minor versions other=
 than 1. Is this correct behavior?</div>
<div><br></div><div>Please let me know.</div><div><br></div><div>Thanks and=
 regards,</div><div>Sandeep.</div></div>

--001a1137087c7f9eb504f476a789--


--===============1380079137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1380079137==--
