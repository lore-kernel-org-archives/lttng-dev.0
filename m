From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Crash on first run of target using
 liblttng-ust-cyg-profile.so, but subsequent runs succeed
Date: Wed, 2 Mar 2016 17:45:49 +0000 (UTC)
Message-ID: <1311958269.14941.1456940749419.JavaMail.zimbra__38026.8627930947$1456940824$gmane$org@efficios.com>
References: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1abAqb-0003Zf-Sy
 for lttng-dev@lists.lttng.org; Wed, 02 Mar 2016 12:46:07 -0500
In-Reply-To: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sean Heelan <seanheelan@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Sean,

As mentioned by Mathieu this is caused by the docker default seccomp profile
blocking the "restart_syscall" syscall. This problem only happens on host
systems where docker 0.10.2 and up was built against libseccomp 2.2.1 and up.

Hopefully docker will add this syscall to their default whitelist but in the
meantime, you can simply get the json profile [1] from git and add this :

  {
    "name": "restart_syscall",
    "action": "SCMP_ACT_ALLOW",
     "args": []
  }

Then start your container with "--security-opt seccomp:/path/to/myprofile.json".

Hope it helps,

Michael


[1] https://github.com/docker/docker/blob/master/profiles/seccomp/default.json


----- On Feb 11, 2016, at 9:01 AM, Sean Heelan seanheelan@gmail.com wrote:

> Hi all,
> 
> I am running a target within a Docker instance, and tracing function execution
> using the latest LTTng release (2.7). The commands I am issuing look as
> follows:
> 
> ----
> lttng create cc_session -o bla
> lttng enable-event --userspace lttng_ust_cyg_profile:func_entry
> lttng start
> 
> LD_PRELOAD=liblttng-ust-cyg-profile.so target
> 
> lttng stop
> lttng destroy
> ----
> 
> When the target is executed it aborts with the following error:
> 
> ----
> php: lttng-ust-comm.c:1582: lttng_ust_init: Assertion `!ret' failed.
> ----
> 
> If I rerun the command it then works fine. In fact, simply doing the following
> within the Docker container demonstrates the issue:
> 
> ----
> LD_PRELOAD=liblttng-ust-cyg-profile.so ls
> LD_PRELOAD=liblttng-ust-cyg-profile.so ls
> ----
> 
> The first 'ls' will fail at the same point mentioned above, while the second
> will succeed. Off the top of my head I'm struggling to come up with an
> explanation as to what impact the first execution using LD_PRELOAD would have
> on the second. Does it impact a shared lib cache in some way, which I'm unaware
> of?
> 
> Any assistance would be appreciated!
> 
> Sean
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
