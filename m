From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Machine Interface
Date: Thu, 13 Feb 2014 13:26:09 -0500
Message-ID: <CAFXXi0mcn4MUA0iHE-+HGqcqrsyf=wgWXPFMnBJrc+xrF96gaQ__39378.8788155236$1392316065$gmane$org@mail.gmail.com>
References: <52FD0831.7030704@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1WE0zm-00022b-5p
	for lttng-dev@lists.lttng.org; Thu, 13 Feb 2014 13:26:52 -0500
Received: by mail-ig0-f181.google.com with SMTP id j1so13638439iga.2
	for <lttng-dev@lists.lttng.org>; Thu, 13 Feb 2014 10:26:40 -0800 (PST)
In-Reply-To: <52FD0831.7030704@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Olivier Cotte <olivier.cotte@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

It looks good!

Comments below.

On 13 February 2014 13:00, Olivier Cotte <olivier.cotte@polymtl.ca> wrote:
> At first, we wanted thank you for your quick and constructive feedback!
>
> After reflection on the nature of the problem and consideration of your
> feedback, we've arrived with the following solution.
>
> The technology that will be use is XML. The integration of the machine
> interface to LTTng will be done in the most modular manner to facilitate the
> support multiples outputs format. This option will most likely be available
> at configure time.
>
> For the moment, we will focus our effort into adding the XML feature only.
> If many outputs languages is still a viable feature, it will be possible to
> investigate.
>
> Our main goal is of course to promote extensibility, ease of development for
> new tools and establish a standards for the communication control flow. Here
> are our primary requirement concerning the machine interface:
>
>   * Fit the tree structure of LTTng commands structures.
>   * It can be parse from bash/shell script with no external helpers.
>   * The new format must not introduce any dependencies to LTTng.
>   * [Optional] Still human readable, but fit to be parse.This is not a
>      priority since we are talking about a machine interface.
>
> Here are the reason why we think XML should be used for the machine
> interface:
>
>   * The expression of LTTng hierarchy really fit a XML tree structure.
>   * Since Jgalar add a load-save feature that depend on libxml2, we are
>     not introducing any dependencies. Choosing another format would
>     most likely introduce new dependency.
>   * XML is robust and easily extensible. It will also be easy to
>     maintains (add new commands, modify existing commands etc.)
>   * There are tools that allow you to evaluate XPath expressions from
>     the bash.

In the requirements above, you said "It can be parse from bash/shell
script with no external helpers". For XML it's not really the case. I
don't really mind (I am fine withXML), but I just think those are
contradictory statements.

>   * XML is an established standard
>
> That's why we consider XML format as a suitable solution.
>
> Now for the machine interface syntax:
>
>   * Since we are aware that multiple output could be supported, we want an
>     unify flag for all machine interface command.
> The flag --xml would be used to output xml from LTTng (we could add
> similar
> options like --json, --yaml etc.). This would be similar to svn
> machine interface and speak for itself.
>   * Also, to avoid confusion we will use a different primary command for
> input and
>     output machine interface.
> Ex: lttng machine <input>
> Ex: lttng --xml <output>

Can you give an (preliminary) example usage of lttng machine ? The XML
document would be a big string / a single argument ?

Also, could lttng machine also be able to read its input from stdin?
If it does, could it receive multiple commands in a single invocation?
For example, each root-level XML element could represent a command.
This way, a program would have to do a single exec and then push all
the commands one by one to the lttng client.

I have not really thought this through, I am just putting the idea in the wild.

> Any points we are missing?

I don't know how it would look, but as a user/developer, it would be
nice if there was a way for lttng to dump me the XML that corresponds
to a command (e.g. what I need to feed lttng machine to have the same
effect as a command).

Example with syntax I just made up:

lttng --dump-xml-input enable-event -k sched_switch,other_event

would output

<lttng>
    <command name="enable-event" domain="kernel">
        <event name="sched_switch"/>
        <event name="other_event"/>
    </command>
</lttng>

I feel that this feature would make the machine interface more
approachable (less doc to read before you start being efficient). What
do you think?

Simon
