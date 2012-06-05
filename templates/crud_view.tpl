<h1>{@jelix~crud.title.view@}</h1>
{formdatafull $form}


<ul class="crud-links-list">
    {foreach $actions as $action}
        {if $action == 'edit'}
            <li><a href="{jurl $editAction, array('id'=>$id, $offsetParameterName=>$page)}" class="crud-link icon-edit">{@jelix~crud.link.edit.record@}</a></li>
        {elseif $action == 'delete'}
            <li><a href="{jurl $deleteAction, array('id'=>$id, $offsetParameterName=>$page)}" class="crud-link icon-delete" onclick="return confirm('{@jelix~crud.confirm.deletion@}')">{@jelix~crud.link.delete.record@}</a>
            </li>
        {elseif $action == 'create'}
            <li><a href="{jurl $createAction}" class="crud-link icon-create">{@jelix~crud.link.create.record@}</a></li>
        {elseif $action == 'list'}
            <li><a href="{jurl $listAction, array($offsetParameterName=>$page)}" class="crud-link icon-list">{@jelix~crud.link.return.to.list@}</a></li>
        {/if}
    {/foreach}
</ul>

