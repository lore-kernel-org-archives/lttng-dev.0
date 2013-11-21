From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a modul (driver)
Date: Thu, 21 Nov 2013 10:48:59 +0100
Message-ID: <528DD70B.8040504__48736.5131186836$1385027362$gmane$org@gmx.de>
References: <527DF369.4020704@gmx.de> <5283B8BD.9020703@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0202477706=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.15])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1VjQsD-0005Ni-RZ
	for lttng-dev@lists.lttng.org; Thu, 21 Nov 2013 04:48:36 -0500
Received: from [192.168.178.21] ([88.64.178.221]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0LlV4F-1V9GZg2Z8R-00bKZx for
	<lttng-dev@lists.lttng.org>; Thu, 21 Nov 2013 10:48:27 +0100
In-Reply-To: <5283B8BD.9020703@gmx.de>
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
--===============0202477706==
Content-Type: multipart/alternative;
 boundary="------------020704050402020202040603"

This is a multi-part message in MIME format.
--------------020704050402020202040603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Nobody can help me?

now i have ubuntu 13.10 installed  in a vmware.
but i have the same error!

s$ sudo make modules_install
make -C /lib/modules/3.11.0-12-generic/build 
M=/home/klaus/lttng_src/lttng-modules modules_install
make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
   INSTALL /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer.ko
Can't read private key
....
lsmod | grep lttng
-> no module found

Thanks!

Am 13.11.2013 18:37, schrieb Klaus Dannecker:
>
> Am 09.11.2013 09:33, schrieb Klaus Dannecker:
>> Hi,
>> I want to write a driver with trace events.
>> In the first step i compile the example  trace-events-sample.c with 
>> the makefile:
>>
>> ifneq ($(KERNELRELEASE),)
>>     obj-m  := modul_trace-events-sample.o
>>     modul_trace-events-sample-y := trace-events-sample.o
>>     ccflags-y := -I$(src)
>> else
>>     KDIR ?= /lib/modules/`uname -r`/build
>> default:
>>     $(MAKE) -C $(KDIR) M=$$PWD
>> endif
>>
>> now i get the modul_trace-events-sample.ko File.
>> now:
>> insmod modul_trace-events-sample.ko
>> lttng create
>> lttng enable-event -k -a
>> lttng start
>> ...wait...
>> lttng stop
>> lttng destroy
>>
>> now i look the result in the eclise viewer, but i found event 
>> "trace_foo_bar" not in the session!
>> what am I doing wrong?
>>
>> I use ubuntu 13.04 in a vmware
>>
>> Thanks
>>
>> _______________________________________________
> Hi,
>
> now i found a answer:
> http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
> now i download the lttng-module and compiled it.
> |$ git clone git://git.lttng.org/lttng-modules.git
> ||$ cd lttng-tools|
> |$ make|
> |$ sudo make modules_install
> |here I get  error
> INSTALL /mnt/hgfs/shared_Folder/lttng-modules/lib/lttng-lib-ring-buffer.ko
> Can't read private key
> ...
> what does that mean?
> what  should I do?
>
> please help me!
>
> another question:
> when i create atrace events in module_a,
> can i use it in module_b?
> if yes,what  should I do?
> thanks Klaus
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------020704050402020202040603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi,<br>
    <br>
    <span id="result_box" class="short_text" lang="en"><span class="hps">Nobody
        can</span> <span class="hps">help me?<br>
        <br>
        now i have </span></span><span id="result_box"
      class="short_text" lang="en"><span class="hps">ubuntu </span></span><span
      id="result_box" class="short_text" lang="en"><span class="hps">13.10
      </span></span><span id="result_box" class="short_text" lang="en"><span
        class="hps">installed&nbsp; in a vmware.<br>
        but i have the same error!<br>
        <br>
        s$ sudo make modules_install<br>
        make -C /lib/modules/3.11.0-12-generic/build
        M=/home/klaus/lttng_src/lttng-modules modules_install<br>
        make[1]: Entering directory
        `/usr/src/linux-headers-3.11.0-12-generic'<br>
        &nbsp; INSTALL
        /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer.ko<br>
        Can't read private key<br>
        ....<br>
        lsmod | grep lttng<br>
        -&gt; no module found<br>
        <br>
        Thanks!<br>
        <br>
      </span></span>
    <div class="moz-cite-prefix">Am 13.11.2013 18:37, schrieb Klaus
      Dannecker:<br>
    </div>
    <blockquote cite="mid:5283B8BD.9020703@gmx.de" type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      <br>
      <div class="moz-cite-prefix">Am 09.11.2013 09:33, schrieb Klaus
        Dannecker:<br>
      </div>
      <blockquote cite="mid:527DF369.4020704@gmx.de" type="cite">Hi, <br>
        I want to write a driver with trace events. <br>
        In the first step i compile the example&nbsp; trace-events-sample.c
        with the makefile: <br>
        <br>
        ifneq ($(KERNELRELEASE),) <br>
        &nbsp;&nbsp;&nbsp; obj-m&nbsp; := modul_trace-events-sample.o <br>
        &nbsp;&nbsp;&nbsp; modul_trace-events-sample-y := trace-events-sample.o <br>
        &nbsp;&nbsp;&nbsp; ccflags-y := -I$(src) <br>
        else <br>
        &nbsp;&nbsp;&nbsp; KDIR ?= /lib/modules/`uname -r`/build <br>
        default: <br>
        &nbsp;&nbsp;&nbsp; $(MAKE) -C $(KDIR) M=$$PWD <br>
        endif <br>
        <br>
        now i get the modul_trace-events-sample.ko File. <br>
        now: <br>
        insmod modul_trace-events-sample.ko <br>
        lttng create <br>
        lttng enable-event -k -a <br>
        lttng start <br>
        ...wait... <br>
        lttng stop <br>
        lttng destroy <br>
        <br>
        now i look the result in the eclise viewer, but i found event
        "trace_foo_bar" not in the session! <br>
        what am I doing wrong? <br>
        <br>
        I use ubuntu 13.04 in a vmware <br>
        <br>
        Thanks <br>
        <br>
        _______________________________________________ <br>
      </blockquote>
      Hi,<br>
      <br>
      now i found a answer:<br>
      <a moz-do-not-send="true" class="moz-txt-link-freetext"
href="http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html">http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html</a><br>
      now i download the lttng-module and compiled it.<br>
      <pre><code>$ git clone git:<wbr>//gi<wbr>t.lt<wbr>tng.<wbr>org/<wbr>lttn<wbr>g-mo<wbr>dule<wbr>s.gi<wbr>t
</code><code>$ cd lttng-tools</code>
<code>$ make</code>
<code>$ sudo make modules_install
</code><span id="result_box" class="short_text" lang="en"><span class="hps">here I get</span> <span class="hps">error
INSTALL /mnt/hgfs/shared_Folder/lttng-modules/lib/lttng-lib-ring-buffer.ko
Can't read private key
...
</span></span><span id="result_box" class="short_text" lang="en"><span class="hps">what does that mean?
</span></span><span id="result_box" class="short_text" lang="en"><span class="hps"><span id="result_box" class="short_text" lang="en"><span class="hps"><span id="result_box" class="short_text" lang="en"><span class="hps"><span id="result_box" class="short_text" lang="en"><span class="hps">what</span> <span class="hps">should I do?</span></span></span></span></span></span>

please help me!

</span></span><span id="result_box" class="short_text" lang="en"><span class="hps"><span id="result_box" class="short_text" lang="en"><span class="hps">another question:
when i create a </span></span></span></span><span id="result_box" class="short_text" lang="en"><span class="hps"><span id="result_box" class="short_text" lang="en"><span class="hps">trace events in module_a,
can i use it in module_b?
if yes, </span></span></span></span><span id="result_box" class="short_text" lang="en"><span class="hps"><span id="result_box" class="short_text" lang="en"><span class="hps"><span id="result_box" class="short_text" lang="en"><span class="hps">what</span> <span class="hps">should I do?</span></span></span></span></span></span></pre>
      thanks Klaus<br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020704050402020202040603--


--===============0202477706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0202477706==--
