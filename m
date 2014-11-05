From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: babeltrace-python bindings
Date: Wed, 5 Nov 2014 00:56:44 -0500
Message-ID: <CAB4xu_3VGFWHmdtFE1AwOFCSPcAfR12r4qapPy9ie+kBF3V9AA__8823.12599937922$1415167083$gmane$org@mail.gmail.com>
References: <CAETqSHAgdD8_9XZZvc_LTmD_pUHSV=i05h4sqww7gDFf+WGU+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Xltaq-00033r-Pv
 for lttng-dev@lists.lttng.org; Wed, 05 Nov 2014 00:57:22 -0500
Received: by mail-qa0-f47.google.com with SMTP id dc16so41886qab.6
 for <lttng-dev@lists.lttng.org>; Tue, 04 Nov 2014 21:57:15 -0800 (PST)
In-Reply-To: <CAETqSHAgdD8_9XZZvc_LTmD_pUHSV=i05h4sqww7gDFf+WGU+w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bin YE <yebinianhi@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Nov 4, 2014 at 5:37 PM, Bin YE <yebinianhi@gmail.com> wrote:
> Hi there
>
> i have installed Lttng and babeltrace
> my system:Ubuntu 14.04LTS
> I have made following steps
>
> sudo apt-add-repository ppa:lttng/ppa
> sudo apt-get update
> sudo apt-get install lttng-tools
> sudo apt-get install lttng-modules-dkms
> sudo apt-get install liblttng-ust-dev
>
> export PYTHON="python3"
> export PYTHON_CONFIG="/usr/bin/python3-config"
>
> ./configure --enable-python-bindings
>  make
>  make install
>  ldconfig
>
> but i still can not use babeltrace python bindings
> when i run import babeltrace it output error with no module

What is the output of this command:

    ls /usr/lib/python3.*/site-packages

?

Philippe Proulx
>
> I really need you help about it
> Thank you very much in advance
>
> Bin Ye
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
