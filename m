From: Bernd Hufmann <bernd.hufmann@ericsson.com>
Subject: Re: [RELEASE] LTTng-Tools 2.6.0-rc1 - Gaia
Date: Wed, 29 Oct 2014 14:45:11 -0400
Message-ID: <545135B7.50702__2529.43679593063$1414608372$gmane$org@ericsson.com>
References: <20141020172654.GE15954@thessa> <54455805.9060104@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0253822354=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bernd.hufmann@ericsson.com>) id 1XjYFC-00060u-Er
 for lttng-dev@lists.lttng.org; Wed, 29 Oct 2014 14:45:21 -0400
In-Reply-To: <54455805.9060104@ericsson.com>
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

--===============0253822354==
Content-Type: multipart/alternative;
	boundary="------------090805050408030602050702"

--------------090805050408030602050702
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Hello

I'd like to get some understanding about this. So, any comments on the 
reported error below?

Thanks
Bernd

On 10/20/2014 02:44 PM, Bernd Hufmann wrote:
> Hello
>
> I just tried to configure the metadata channel for UST. After that I 
> get an error when listing the session.
> Could someone please verify this? See below for the commands I used 
> and the error message.
>
> Many thanks in advance!
>
> Best Regards
> Bernd
>
> > lttng create
> Session auto-20141020-141307 created.
> Traces will be written in /home/bernd/lttng-traces/auto-20141020-141307
>
> >lttng enable-channel --subbuf-size 8192 -u metadata
> UST channel metadata enabled for session auto-20141020-141307
> >lttng list auto-20141020-141307
> Tracing session auto-20141020-141307: [inactive]
>     Trace path: /home/bernd/lttng-traces/auto-20141020-141307
>
> === Domain: UST global ===
>
> Buffer type: per UID
>
> Error: UST channel not found
> Error: Command error
>
>
>
> On 10/20/2014 01:26 PM, David Goulet wrote:
>> Greetings everyone (including LTTng bards!),
>>
>> The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
>> a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
>> library for tracing control and a lttng-relayd for network streaming and live
>> reading.
>>
>> This is the release candidate number 1 of version 2.6, code name: Gaia.
>>
>> This features are listed below but here is a quick howto to use them. For the
>> MI feature, simply adds to the lttng command line the option "--mi xml". Only
>> XML is supported for now.
>>
>> 	lttng --mi xml version
>>
>> Note that there are now new lines for parsing efficiency. You can find the XML
>> schema in "src/common/mi_lttng.xsd". Big thanks to Jonathan Rajotte for this
>> great feature that the lttng bash completion file has already started using it!
>>
>> Also, Java log4j support has been added as a new domain (like JUL) that you can
>> use with the command line option -l, --log4j and with the API using
>> LTTNG_DOMAIN_LOG4J.
>>
>> Finally, it's now possible to do per syscall tracing. You can get a full list
>> of the available syscalls on your system with "lttng list -k --syscall". To
>> enable a syscall, use its name like so:
>>
>> 	lttng enable-event -k --syscall connect
>>
>> Note that it's not possible to choose the bitness of the syscall thus for
>> instance enabling "read" on a kernel supporting both 32 and 64 bit will enabled
>> both of them.
>>
>> Of course, we fix a BUNCH of things that hopefully will make lttng tools more
>> stable and powerful :). Here is the ChangeLog entry for 2.6-rc1.
>>
>> 2014-10-20 lttng-tools 2.6.0-rc1 (Harry Belafonte records Banana Boat Song)
>> 	* Machine Interface added to lttng command line (--mi)
>> 	* Java Log4j agent support (--log4j)
>> 	* Kernel per syscall tracing
>> 	* Multiple fixes. A lot!
>>
>> Please report ANY issues to bugs.lttng.org or on that mailing list.
>>
>> Using it is testing it!
>>
>> Project website:https://lttng.org
>> Download link:
>> https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2
>> GPG sig:https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2.asc
>>
>> Cheers!
>> David
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------090805050408030602050702
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hello<br>
    <br>
    I'd like to get some understanding about this. So, any comments on
    the reported error below?<br>
    <br>
    Thanks<br>
    Bernd<br>
    <br>
    <div class=3D"moz-cite-prefix">On 10/20/2014 02:44 PM, Bernd Hufmann
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:54455805.9060104@ericsson.com" type=3D"cite">=

      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      Hello<br>
      <br>
      I just tried to configure the metadata channel for UST. After that
      I get an error when listing the session.<br>
      Could someone please verify this? See below for the commands I
      used and the error message.<br>
      <br>
      Many thanks in advance!<br>
      <br>
      Best Regards<br>
      Bernd<br>
      <br>
      &gt; lttng create<br>
      Session auto-20141020-141307 created.<br>
      Traces will be written in
      /home/bernd/lttng-traces/auto-20141020-141307<br>
      <br>
      &gt;lttng enable-channel --subbuf-size 8192 -u metadata<br>
      UST channel metadata enabled for session auto-20141020-141307<br>
      &gt;lttng list auto-20141020-141307<br>
      Tracing session auto-20141020-141307: [inactive]<br>
      =A0=A0=A0 Trace path: /home/bernd/lttng-traces/auto-20141020-141307=
<br>
      <br>
      =3D=3D=3D Domain: UST global =3D=3D=3D<br>
      <br>
      Buffer type: per UID<br>
      <br>
      Error: UST channel not found<br>
      Error: Command error<br>
      <br>
      <br>
      <br>
      <div class=3D"moz-cite-prefix">On 10/20/2014 01:26 PM, David Goulet=

        wrote:<br>
      </div>
      <blockquote cite=3D"mid:20141020172654.GE15954@thessa" type=3D"cite=
">
        <pre wrap=3D"">Greetings everyone (including LTTng bards!),

The lttng-tools project provides a session daemon (lttng-sessiond) that a=
cts as
a tracing registry, the "lttng" command line for tracing control, a lttng=
-ctl
library for tracing control and a lttng-relayd for network streaming and =
live
reading.

This is the release candidate number 1 of version 2.6, code name: Gaia.

This features are listed below but here is a quick howto to use them. For=
 the
MI feature, simply adds to the lttng command line the option "--mi xml". =
Only
XML is supported for now.

	lttng --mi xml version

Note that there are now new lines for parsing efficiency. You can find th=
e XML
schema in "src/common/mi_lttng.xsd". Big thanks to Jonathan Rajotte for t=
his
great feature that the lttng bash completion file has already started usi=
ng it!

Also, Java log4j support has been added as a new domain (like JUL) that y=
ou can
use with the command line option -l, --log4j and with the API using
LTTNG_DOMAIN_LOG4J.

Finally, it's now possible to do per syscall tracing. You can get a full =
list
of the available syscalls on your system with "lttng list -k --syscall". =
To
enable a syscall, use its name like so:

	lttng enable-event -k --syscall connect

Note that it's not possible to choose the bitness of the syscall thus for=

instance enabling "read" on a kernel supporting both 32 and 64 bit will e=
nabled
both of them.

Of course, we fix a BUNCH of things that hopefully will make lttng tools =
more
stable and powerful :). Here is the ChangeLog entry for 2.6-rc1.

2014-10-20 lttng-tools 2.6.0-rc1 (Harry Belafonte records Banana Boat Son=
g)
	* Machine Interface added to lttng command line (--mi)
	* Java Log4j agent support (--log4j)
	* Kernel per syscall tracing
	* Multiple fixes. A lot!

Please report ANY issues to bugs.lttng.org or on that mailing list.

Using it is testing it!

Project website: <a moz-do-not-send=3D"true" class=3D"moz-txt-link-freete=
xt" href=3D"https://lttng.org">https://lttng.org</a>
Download link:
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" href=3D"https=
://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2">https://ltt=
ng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2</a>
GPG sig: <a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" href=
=3D"https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2.asc=
">https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2.asc</=
a>

Cheers!
David
</pre>
        <br>
        <fieldset class=3D"mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap=3D"">_______________________________________________
lttng-dev mailing list
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated" href=3D"ma=
ilto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" href=3D"http:=
//lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
      </blockquote>
      <br>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttn=
g.org">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------090805050408030602050702--


--===============0253822354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0253822354==--
