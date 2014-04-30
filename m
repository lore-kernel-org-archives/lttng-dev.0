From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [RFC Patch Tools 0/4] Configurable lttng-probe
 modules
Date: Wed, 30 Apr 2014 14:19:20 +0200
Message-ID: <20140430121919.GA5780__40943.7474249446$1398860455$gmane$org@hal>
References: <cover.1396521858.git.jan.glauber@gmail.com>
 <20140410194551.GD28773@dalia> <20140411084046.GA15028@hal>
 <20140414184051.GD32712@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WfTUM-0003ZX-J5
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 08:19:56 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so1293599eek.18
 for <lttng-dev@lists.lttng.org>; Wed, 30 Apr 2014 05:19:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140414184051.GD32712@thessa>
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

On Mon, Apr 14, 2014 at 02:40:51PM -0400, David Goulet wrote:
> On 11 Apr (10:40:47), Jan Glauber wrote:
> > On Thu, Apr 10, 2014 at 03:45:51PM -0400, David Goulet wrote:

Hi David,

sorry for my vacational late response. Some more questions...
 
> As of now, you have to pass it to the daemon:
> 
>   -f  --config                       Load daemon configuration file
> 
> For 2.5, we want to have a default config. file installed in /etc/lttng/
> and provide also documentation on it with probably a man page.
> 
> We went with the INI file format so in our case here I can see a simple
> option like:
> 
> modules = probe1, probe2, probe3, ...

For the env variable I choose an PATH-like format so currently it is:
"probe1:probe2:...".
Should I change this to match the config file format then?

> and by default load ALL.
> 
> > 
> > > Anyhow, I'm comfortable merging this and adding this env. var but an
> > > option in the configuration file could also be awesome! :)

I'm looking into this now but its not obvious to me how the config file
should look like. If I provide an empty config file lttng seems to not
have any config options and fails to start. So do you have an example of
a working config file?

I guess because its INI based there should be sections? Which?

Jan
