From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [RFC Patch Tools 0/4] Configurable lttng-probe
 modules
Date: Fri, 11 Apr 2014 10:40:47 +0200
Message-ID: <20140411084046.GA15028__26146.667256444$1397205780$gmane$org@hal>
References: <cover.1396521858.git.jan.glauber@gmail.com>
 <20140410194551.GD28773@dalia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WYX2F-0007vO-QS
 for lttng-dev@lists.lttng.org; Fri, 11 Apr 2014 04:42:08 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so3875648eek.1
 for <lttng-dev@lists.lttng.org>; Fri, 11 Apr 2014 01:42:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140410194551.GD28773@dalia>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Apr 10, 2014 at 03:45:51PM -0400, David Goulet wrote:
> On 03 Apr (12:57:43), Jan Glauber wrote:
> > Hi LTTng'ers,
> > 
> > I've asked briefly for the configurable probes feature at the Tracing summit,
> > here is an RFC how we could implement it.
> > 
> > Why I want to have this feature:
> > Currently the LTTng probes that are loaded when a session is created are defined
> > in a static list. If the user wants to change the loaded probes (for instance
> > disable the very noisy rcu) then lttng-tools must be recompiled or the modules must
> > be blacklisted or deleted. I also found that in our embedded environment the default
> > busybox configuration is to disable the blacklist feature, so blacklisting is not an
> > option.
> > 
> > Therefore I want to have a more flexible way of defining which probes to load
> > on session start. We could use an environment variable that (if present)
> > overrides the default and only loads the probes named in the variable.
> > 
> > Patch 1 is a cleanup and patch 2 & 3 are preparation for the feature in patch 4.
> > Please review and give feedback if this approach is feasible.
> 
> Hi Jan,
> 
> First of all, thanks for this! Except some syntax issue, this looks
> great! Sorry took a while to respond, busy busy improving lttng :P.

Hi David,

thanks for reviewing! Also, I hope part of the improvement work was to decide
on the name for the 2.5 release ;-

> Before we go further in mergin this, I see you took the approach of
> adding an env. variable to provide the list of probes you want to load.
> Right now in the upstream master (for 2.5), we have the support for a
> configuration file for lttng-sessiond. Could it be a way you would
> prefer (or use) instead of env. var? I understand that embedded stuff, a
> conf file might not be preferable.

Actually a config file was my first thought also, but I only found the .lttngrc
which is generated when a session is started. Where is the sessiond config file
located? I don't see a config file under /etc or in the home directory.

> Anyhow, I'm comfortable merging this and adding this env. var but an
> option in the configuration file could also be awesome! :)
>
> One thing that would be great if you have a minute, is to send me a
> patch for the man page update of that new variable.

I'll do that when we've decided about config file vs. env variable...

--Jan


> Cheers!
> David
> 
> > 
> > thanks,
> > Jan
> > ---
> > Harman Becker Automotive GmbH
> > System Profiling & Optimizing Team
> > 
> > 
> > Jan Glauber (4):
> >   Use common functions for module loading and unloading
> >   Seperate probe modules from control modules
> >   Remove required parameter from module parameters
> >   Dynamic probe list support
> > 
> >  src/bin/lttng-sessiond/kern-modules.h |    3 +-
> >  src/bin/lttng-sessiond/modprobe.c     |  292 ++++++++++++++++++---------------
> >  src/common/defaults.h                 |    3 +
> >  src/common/utils.c                    |   10 ++
> >  src/common/utils.h                    |    1 +
> >  5 files changed, 172 insertions(+), 137 deletions(-)
> > 
> > -- 
> > 1.7.9.5
> > 
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
