From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: lttng on android
Date: Mon, 21 Jan 2013 10:43:46 -0500
Message-ID: <50FD6232.3060209__8378.16840871728$1358783078$gmane$org@versatic.net>
References: <CAHg4Oy8D-TDOkvQV5qpFBfC3RM_=57uwyWD067m2guxaupr-8A@mail.gmail.com>
	<50FD5D83.5070308@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0316438307=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien@versatic.net>) id 1TxJXH-0003BU-GS
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 10:43:47 -0500
Received: from [132.207.169.211] ([132.207.169.211])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id r0LFhk38018059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2013 10:43:47 -0500
In-Reply-To: <50FD5D83.5070308@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0316438307==
Content-Type: multipart/alternative;
 boundary="------------080707050605040400010407"

This is a multi-part message in MIME format.
--------------080707050605040400010407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id r0LFhk38018059

Hi Amit,

Indeed there is a group of students working on putting lttng on android,=20
maybe make it work through adb.  As the semester advances, they may=20
publish some of their work and hopefully by the end of april, lttng will=20
be supported and documented on Android.

In the meantime, if you have managed to compile and modprobe the=20
modules, have you tried obtaining a trace from the command line. What=20
does it do, what message do you get?

Genevi=E8ve


On 01/21/2013 10:23 AM, Matthew Khouzam wrote:
> I believe a group at l'ecole polytechnique de Montreal is working on=20
> this, Genvieve, could you please comment more?
>
> On 13-01-21 06:48 AM, Amit Balboul wrote:
>> Hi,
>>
>> Is there a way to build the LTTng tools to Android (3.0.31) on ARM ??
>>
>> I've managed to compile the modules(2.0.6), put them in the Android=20
>> device and modprobe them.
>> Now I would like to extract the traces logs from the device.
>> How can I do it ?
>> Is there any support for this at all in the LTTng project ?
>>
>>
>> Thank you for your response !
>>
>> Amit.
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--------------080707050605040400010407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Amit,<br>
      <br>
      Indeed there is a group of students working on putting lttng on
      android, maybe make it work through adb.&nbsp; As the semester
      advances, they may publish some of their work and hopefully by the
      end of april, lttng will be supported and documented on Android.<br>
      <br>
      In the meantime, if you have managed to compile and modprobe the
      modules, have you tried obtaining a trace from the command line.&nbsp;
      What does it do, what message do you get?<br>
      <br>
      Genevi&egrave;ve<br>
      <br>
      <br>
      On 01/21/2013 10:23 AM, Matthew Khouzam wrote:<br>
    </div>
    <blockquote cite="mid:50FD5D83.5070308@ericsson.com" type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      I believe a group at l'ecole polytechnique de Montreal is working
      on this, Genvieve, could you please comment more?<br>
      <br>
      <div class="moz-cite-prefix">On 13-01-21 06:48 AM, Amit Balboul
        wrote:<br>
      </div>
      <blockquote
cite="mid:CAHg4Oy8D-TDOkvQV5qpFBfC3RM_=57uwyWD067m2guxaupr-8A@mail.gmail.com"
        type="cite">
        <meta http-equiv="Content-Type" content="text/html;
          charset=ISO-8859-1">
        <div dir="ltr">Hi,
          <div><br>
          </div>
          <div style="">Is there a way to build the LTTng tools to
            Android (3.0.31) on ARM ??</div>
          <div style=""><br>
          </div>
          <div style="">I've managed to compile the modules(2.0.6), put
            them in the Android device and modprobe them.</div>
          <div style="">Now I would like to extract the traces logs from
            the device.</div>
          <div style="">How can I do it ?</div>
          <div style="">Is there any support for this at all in the
            LTTng project ?</div>
          <div style=""><br>
          </div>
          <div style=""><br>
          </div>
          <div style="">Thank you for your response !</div>
          <div style=""><br>
          </div>
          <div style="">Amit.</div>
        </div>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
lttng-dev mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------080707050605040400010407--


--===============0316438307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0316438307==--
