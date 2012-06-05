{if $id === null}

<h1>{@jelix~crud.title.create@}</h1>
{formfull $form, $submitAction}

<p><a href="{jurl $listAction, array($offsetParameterName=>$page)}" class="crud-link icon-list">{@jelix~crud.link.return.to.list@}</a></p>

{else}

<h1>{@jelix~crud.title.update@}</h1>
{formfull $form, $submitAction, array('id'=>$id, $offsetParameterName=>$page)}

<ul class="crud-links-list">
    {foreach $actions as $action}
        {if $action == 'view'}
            <li><a href="{jurl $viewAction,array('id'=>$id, $offsetParameterName=>$page)}" class="crud-link icon-view">{@jelix~crud.link.view.record@}</a></li>
        {elseif $action == 'delete'}
            <li><a href="{jurl $deleteAction, array('id'=>$id, $offsetParameterName=>$page)}" class="crud-link icon-delete" onclick="return confirm('{@jelix~crud.confirm.deletion@}')">{@jelix~crud.link.delete.record@}</a>
            </li>
        {elseif $action == 'list'}
            <li><a href="{jurl $listAction, array($offsetParameterName=>$page)}" class="crud-link icon-list">{@jelix~crud.link.return.to.list@}</a></li>
        {elseif $action == 'create'}
            <li><a href="{jurl $createAction}" class="crud-link icon-create">{@jelix~crud.link.create.record@}</a></li>
        {/if}
    {/foreach}
</ul>


{/if}

