From: Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
Subject: Re: Viewing userspace apps traces
Date: Wed, 03 Oct 2012 23:41:53 -0400
Message-ID: <506D0581.3030400__23661.8792092942$1349389697$gmane$org@polymtl.ca>
References: <506B4A21.6080309@fnac.net> <506B4EA4.8050407@voxpopuli.im>
	<506BD225.3030906@fnac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexandre.montplaisir@polymtl.ca>)
	id 1TJcJz-00041J-CM
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 23:41:59 -0400
In-Reply-To: <506BD225.3030906@fnac.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Chavent <paul.chavent@fnac.net>
Cc: lttng-dev@lists.lttng.org, Linux Tools developer discussions <linuxtools-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

Sorry for the late reply, I had to update/rebase some of the stuff first...

(Cross-posting linuxtools-dev, as it might interest some people who
follow that list too. This is about extending TMF to implement a
graphical view for a specific UST trace type.)


On 12-10-03 01:50 AM, Paul Chavent wrote:
> [...]
>
> On 10/02/2012 10:29 PM, Alexandre Montplaisir wrote:
>> [...]
>>
>> What would you like see in your "timeline representation" exactly? Maybe
>> we could give you some pointers as to how to implement such a view.
>> (We're currently working on making it easy to extend the framework to
>> implement new views, so this could be a good exercise!)
>
> I would like to see, eg, one line per tid, and on each line, the value
> of one context or argument value.
>
> I'm ready to follow an exercise for extending the framework !

Ok good! We don't have a nice tutorial ready yet, as most parts are
still working their way upstream. But if you want to dig into it and try
it out now, you can:

1 - Set up the development environment for TMF:
http://wiki.eclipse.org/Linux_Tools_Project/LTTng_Eclipse_Plug-in_Developme=
nt_Environement_Setup

2 - Checkout the "lttng-kepler" branch in the git. This is where the
latest development happens.

3 - Apply those two patches, in that order:
https://git.eclipse.org/r/#/c/7747/
https://git.eclipse.org/r/#/c/7748/
(you can copy-paste the "cherry-pick" command shown on the page)

4 - Download the example program and view from:
git://git.dorsal.polymtl.ca/~alexmont/ust-example.git

Now at this point you should be able to import and build the example
plugins (ust.example.core and ust.example.ui) and the TMF/LTTng ones in
the same workspace.

You can try it to make sure it works correctly : take a UST trace of the
"myprog" program, and then load it into TMF, and show the "Example ->
Connections" view. It should display the yellow and green rectangles
corresponding to the states that were defined.


After that, it shouldn't be too hard (famous last words...) to rework
the ust.example.* code to fit your application. The points of interest
will be (before renames):

MyUstTraceInput, line 85+: This is where you assign your trace events to
states
ConnectionsPresentationProvider, line 31-34: This is where you assign
the colors to each state in the view
and same file, lines 64-68 and 81-85 : This is where you assign the
trace's states to the ones in the view.
(one place is for the actual colored rectangle, the other is for the
tooltips, iirc).


If you have any question or problem, please let me know!

Good luck ;)

-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al
