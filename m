From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: babeltrace-python bindings
Date: Wed, 05 Nov 2014 11:29:02 -0500
Message-ID: <545A504E.10007__47436.3479218029$1415220650$gmane$org@efficios.com>
References: <CAETqSHAgdD8_9XZZvc_LTmD_pUHSV=i05h4sqww7gDFf+WGU+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1Xm7Wf-0007w2-S3
 for lttng-dev@lists.lttng.org; Wed, 05 Nov 2014 15:49:59 -0500
In-Reply-To: <CAETqSHAgdD8_9XZZvc_LTmD_pUHSV=i05h4sqww7gDFf+WGU+w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bin YE <yebinianhi@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

The problem resides with the default search path of Python on Debian/Ubuntu.
When installing manually a Python library, it is installed in
/usr/local/lib/python3.x/site-packages, but Python on Debian/Ubuntu does
not look into this path but does look into dist-packages...

So you can either symlink /usr/local/lib/python3.x/dist-packages so
/usr/local/lib/python3.x/site-packages which is ugly.

Or use this kind of hack at the beginning of your Python program :
try:
    from babeltrace import TraceCollection
except ImportError:
    # quick fix for debian-based distros
    sys.path.append("/usr/local/lib/python%d.%d/site-packages" %
                   (sys.version_info.major, sys.version_info.minor))
    from babeltrace import TraceCollection

You can have a look at this bug report about why it will probably never
be fixed...
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=765022

I hope the workaround at least solves the problem you are having,

Julien

On 14-11-04 05:37 PM, Bin YE wrote:
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
> 
> I really need you help about it
> Thank you very much in advance
> 
> Bin Ye
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
