From: Chandru Mohan <chandru.dav@gmail.com>
Subject: Source code of tracepoint
Date: Wed, 8 Apr 2015 20:49:47 +0530
Message-ID: <CAO6ksyfAEv4i++rNtckvs3JWJCjTOJG2A09bF+0tuebG2PE3Ug__32615.7967014753$1428506447$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0179774145=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chandru.dav@gmail.com>) id 1Yfrlh-0006dv-Fk
 for lttng-dev@lists.lttng.org; Wed, 08 Apr 2015 11:19:54 -0400
Received: by iebmp1 with SMTP id mp1so76925083ieb.0
 for <lttng-dev@lists.lttng.org>; Wed, 08 Apr 2015 08:19:48 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0179774145==
Content-Type: multipart/alternative; boundary=001a1141b9acd0ca8d0513380f63

--001a1141b9acd0ca8d0513380f63
Content-Type: text/plain; charset=UTF-8

Can someone point to the source code of tracepoint in LTTng ? Basically i
would like to understand how the applications communicate with the consumer
daemon and how the traces are being sent by the application.

I could find a definition in tracepoint.h
define tracepoint(provider, name, ...) \

do {                                    \
    STAP_PROBEV(provider, name, ## __VA_ARGS__);            \
    if (caa_unlikely(__tracepoint_##provider##___##name.state)) \
        __tracepoint_cb_##provider##___##name(__VA_ARGS__); \
} while (0)

but could not map it to the exact definition. Kindly provide me your
suggestions.

--001a1141b9acd0ca8d0513380f63
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font=
-size:15px;clear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,=
sans-serif;line-height:19.5px">Can someone point to the source code of trac=
epoint in LTTng ? Basically i would like to understand how the applications=
 communicate with the consumer daemon and how the traces are being sent by =
the application.</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;f=
ont-size:15px;clear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Ari=
al,sans-serif;line-height:19.5px">I could find a definition in tracepoint.h=
</p><h1 style=3D"margin:0px 0px 1em;padding:0px;border:0px;font-size:21px;l=
ine-height:1.3;word-wrap:break-word;font-family:&#39;Helvetica Neue&#39;,He=
lvetica,Arial,sans-serif">define tracepoint(provider, name, ...) \</h1><pre=
 style=3D"margin-top:0px;padding:5px;border:0px;font-size:13px;overflow:aut=
o;width:auto;max-height:600px;font-family:Consolas,Menlo,Monaco,&#39;Lucida=
 Console&#39;,&#39;Liberation Mono&#39;,&#39;DejaVu Sans Mono&#39;,&#39;Bit=
stream Vera Sans Mono&#39;,&#39;Courier New&#39;,monospace,sans-serif;word-=
wrap:normal;background-color:rgb(238,238,238)"><code style=3D"margin:0px;pa=
dding:0px;border:0px;font-family:Consolas,Menlo,Monaco,&#39;Lucida Console&=
#39;,&#39;Liberation Mono&#39;,&#39;DejaVu Sans Mono&#39;,&#39;Bitstream Ve=
ra Sans Mono&#39;,&#39;Courier New&#39;,monospace,sans-serif;white-space:in=
herit">do {                                    \
    STAP_PROBEV(provider, name, ## __VA_ARGS__);            \
    if (caa_unlikely(__tracepoint_##provider##___##name.state)) \
        __tracepoint_cb_##provider##___##name(__VA_ARGS__); \
} while (0)
</code></pre><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font-siz=
e:15px;clear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans=
-serif;line-height:19.5px">but could not map it to the exact definition. Ki=
ndly provide me your suggestions.</p></div>

--001a1141b9acd0ca8d0513380f63--


--===============0179774145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0179774145==--
